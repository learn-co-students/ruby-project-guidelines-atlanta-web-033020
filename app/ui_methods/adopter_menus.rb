def adopter_menu(user)
  selection_valid = false
  options = ["1", "2", "3", "4"]

  puts "Select an option below:"
  puts ""
  puts "1. Update profile"
  puts "2. Adopt a dog"
  puts "3. Become a foster parent"
  puts "4. Logout"

  while !selection_valid
    selection = gets.chomp

    if selection == "1"
      update_profile_menu(user)
    elsif selection == "2"
      adopt_from_foster_menu(user)
    elsif selection == "3"
      join_shelter_menu(user)
    elsif selection == "4" || selection.downcase == "quit"
      logout
      return true
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def update_profile_menu(user)
  selection_valid = false
  options = ["1", "2", "3", "4"]

  while !selection_valid
    puts ""
    puts "What would you like to update?"
    puts "1. Address"
    puts "2. Traits"
    puts "3. Desired Dog Breed"
    puts "4. Desired Dog Age"
    puts "5. Main Menu"
    selection = gets.chomp
    
    if selection == "1"
      address_menu(user)
    elsif selection == "2"
      traits_menu(user)
    elsif selection == "3"
      desired_dog_breed_menu(user)
    elsif selection == "4"
      desired_dog_age_menu(user)
    elsif selection == "5"
      break
    end

    selection_valid = check_valid_selection(options, selection)
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
  puts "Select your traits separated by commas. i.e. 1,2,3"
  Trait.all.each_with_index { |t, index| puts "#{index + 1}. #{t.trait_name}" }
  puts ""
  user_input = gets.chomp
  user.update_traits(user_input.split(","))
end

def desired_dog_breed_menu(user)
  dog_breeds = Dog.all.map { |dog| dog.breed }.uniq

  selection_valid = false
  options = []

  while !selection_valid
    index = 1
    puts ""
    puts "Enter your desired dog breed"
    dog_breeds.each do |breed|
      puts "#{index}. #{breed}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection = gets.chomp
    
    selection_valid = check_valid_selection(options, selection)
  end

  user.update_breed_preference(dog_breeds, selection)
end

def desired_dog_age_menu(user)
  puts ""
  puts "Enter your desired dog age"
  age = gets.chomp.to_i
  user.update_dog_age_preference(age)
end

def adopt_from_foster_menu(user)
  selection_valid = false
  options = []
  
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

    new_best_friend = dogs[selection.to_i - 1]
    user.adopt_dog(new_best_friend)
  
    puts "Thank you for adopting #{new_best_friend.name}!"
    puts "I've never seen his tail wag so fast!"
  end

  puts "Press enter to return to the main menu."
  gets.chomp
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

def join_shelter_menu(user)
  selection_valid = false
  options = []
  shelters = Shelter.shelters_not_joined(user)

  while !selection_valid
    index = 1
    puts ""
    puts "Which shelter would you like to join?"
    shelters.each do |shelter|
      puts "#{index}. #{shelter.name}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection = gets.chomp
    
    selection_valid = check_valid_selection(options, selection)
  end

  user.join_shelter(shelters[selection.to_i - 1])
end

def check_valid_selection(options, selection)
  if options.include? selection
    true
  else
    puts "Invalid selection received. Please choose again."
    false
  end
end