def join_shelter_menu(user)
  shelters = Shelter.shelters_not_joined(user)

  choice = PROMPT.select("Which shelter would you like to join?") do |menu|
    shelters.each_with_index do |s, i|
      menu.choice "#{s.name} at #{s.address}", i
    end
  end

  user.join_shelter(shelters[choice])
end

def update_profile_menu(user)
  puts ""
  choices = ["Address", "Traits", "Desired Dog Breed", "Desired Dog Age", "Back to Main Menu"]
  choice = PROMPT.select("What would you like to update?", choices)
  
  case choice
  when "Address"
    puts "Enter your address"
    user.update_address(get_address)
  when "Traits"
    puts "Select your traits"
    user.update_traits(select_traits)
  when "Desired Dog Breed"
    puts "Select desired dog breed"
    user.update_breed_preference(get_dog_breed)
  when "Desired Dog Age"
    puts "Enter desired dog age"
    user.update_dog_age_preference(get_dog_age)
  end
end

def show_user_criteria(user)
  puts "Breed: #{user.dog_breed_preference}"
  puts "Age:  #{user.dog_age_preference}"
  user.traits.each_with_index do |t, i|
    if i == 0
      puts "Traits: #{t.trait_name}"
    else
      puts "        #{t.trait_name}"
    end
  end
  puts ""
end

def adopt_from_foster_menu(user)
  selection_valid = false
  options = []
  selection = nil
  
  puts ""
  puts "Your criteria:"
  show_user_criteria(user)

  puts "Press Enter to search dogs with your criteria:"
  gets.chomp
  dogs = show_list_of_compatible_dogs(user)
  dogs.each_with_index { |d, i| options << (i + 1).to_s}

  if dogs.empty?
    puts "Looks like all the dogs are adopted!"
  else
    puts "Please select a dog to adopt or type \"quit\" to quit"
    while !selection_valid do
      selection = gets.chomp
      if selection == "quit"
        break
      end
      selection_valid = check_valid_selection(options, selection)
    end
    
    if selection != "quit"
      new_best_friend = dogs[selection.to_i - 1]
      user.adopt_dog(new_best_friend)
    
      puts "Thank you for adopting #{new_best_friend.name}!"
      puts "I've never seen his tail wag so fast!"
    end
  end

  puts "Press enter to return to the main menu."
  gets.chomp
end

def show_list_of_compatible_dogs(user)
  dogs = user.find_compatible_dogs.map { |d| d[:dog]}[0...20]
  puts ""
  table = TTY::Table.new header: ['', 'Name', 'Breed', 'Age', 'Traits']
  dogs.each_with_index do |d, i|
    index = 0
    traits = d.traits
    loop do
      if index == 0
        table << [i + 1, d.name, d.breed, d.age, traits[index] == nil ? "" : traits[index].trait_name]
      else
        table << ["", "", "", "", traits[index].trait_name]
      end
      index += 1
      break if index >= traits.length
    end
  end
  puts table.render(:unicode)
  dogs
end

def check_valid_selection(options, selection)
  if options.include? selection
    true
  else
    puts "Invalid selection received. Please choose again."
    false
  end
end

def get_address
  PROMPT.ask("Address:")
end

def select_traits
  choices = Trait.all.each_with_index.map { |t, i| "#{t.trait_name}" }
  PROMPT.multi_select("Select your traits:", choices)
end

def get_dog_breed
  choices = Dog.all.map { |dog| dog.breed }.uniq
  PROMPT.select("Select your desired dog breed", choices)
end

def get_dog_age
  age = PROMPT.ask("Age:")
end

def get_dog_name
  puts ""
  puts "Enter the dog's name"
  PROMPT.ask("Name:")
end