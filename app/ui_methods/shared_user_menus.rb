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
  when 0
    address_menu(user)
  when 1
    traits_menu(user)
  when 2
    desired_dog_breed_menu(user)
  when 3
    desired_dog_age_menu(user)
  end
end

def address_menu(user)
  puts ""
  puts "Enter your address"
  address = gets.chomp
  user.update_address(address)
end

def traits_menu(user)
  puts ""

  choices = Trait.all.each_with_index.map { |t, i| "#{t.trait_name}" }
  choice = PROMPT.multi_select("Select your traits:", choices)

  user.update_traits(choice)
end

def desired_dog_breed_menu(user)
  puts ""

  choices = Dog.all.map { |dog| dog.breed }.uniq
  choice = PROMPT.select("Select your desired dog breed", choices)

  user.update_breed_preference(choice)
end

def desired_dog_age_menu(user)
  puts ""
  puts "Enter your desired dog age"
  age = PROMPT.ask("Age:")
  user.update_dog_age_preference(age)
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

def update_dog_menu(dog)
  puts ""
  choices = ["Name", "Age", "Breed", "Traits", "Back to Main Menu"]
  choice = PROMPT.select("What would you like to update?", choices)

  case choice
  when "Name"
    dog.update_name(get_dog_name)
  when "Age"
    dog.update_age(get_dog_age)
  when "Breed"
    dog.update_breed(get_dog_breed)
  when "Traits"
    dog.update_traits(get_dog_traits)
  end
end

def get_dog_name
  puts ""
  puts "Enter the dog's name"
  PROMPT.ask("Name:")
end

def get_dog_age
  puts ""
  puts "Enter the dog's age"
  PROMPT.ask("Age:").to_i
end

def get_dog_breed
  dog_breeds = Dog.all.map { |dog| dog.breed }.uniq

  selection_valid = false
  options = []
  selection = ""

  while !selection_valid
    index = 1
    puts ""
    puts "Select the dog's breed"
    dog_breeds.each do |breed|
      puts "#{index}. #{breed}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection  = gets.chomp
    dog_breed = dog_breeds[selection.to_i - 1]

    selection_valid = check_valid_selection(options, selection)
  end
  dog_breed
end

def get_dog_traits
  trait_list = Trait.all
  puts ""
  puts "Select your traits separated by commas. i.e. 1,2,3"
  trait_list.each_with_index { |t, index| puts "#{index + 1}. #{t.trait_name}" }
  puts ""
  user_input = gets.chomp
  trait_nums = user_input.split(",")
  trait_nums.map { |t| t.strip } # remove white space
  .map { |t| trait_list[t.to_i - 1] } # map to trait instances
end