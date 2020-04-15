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