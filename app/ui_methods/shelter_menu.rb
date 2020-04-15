def shelter_menu(shelter)
  selection_valid = false
  options = ["1", "2", "3", "4", "5"]

  puts "Select an option below:"
  puts ""
  puts "1. Update shelter name"
  puts "2. Update shelter address"
  puts "3. Add dog"
  puts "4. Update dog"
  puts "5. Logout"

  while !selection_valid
    selection = gets.chomp

    if selection == "1"
      shelter_update_name_menu(shelter)
    elsif selection == "2"
      shelter_update_address_menu(shelter)
    elsif selection == "3"
      shelter_add_dog_menu(shelter)
    elsif selection == "4"
      shelter_select_dog_to_update_menu(shelter)
    elsif selection == "5" || selection.downcase == "quit"
      logout
      return true
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def shelter_update_name_menu(shelter)
  puts ""
  puts "Enter the new shelter name"
  name = gets.chomp
  shelter.update_name(name)
end

def shelter_update_address_menu(shelter)
  puts ""
  puts "Enter the shelter address"
  address = gets.chomp
  shelter.update_address(address)
end

def shelter_add_dog_menu(shelter)
  name = get_dog_name
  age = get_dog_age
  breed = get_dog_breed
  traits = get_dog_traits

  shelter.add_dog(name, age, breed, traits)
end

def shelter_select_dog_to_update_menu(shelter)
  selection_valid = false
  options = []

  while !selection_valid
    index = 1
    puts ""
    puts "Select which dog you would like to update"
    shelter.dogs.each do |dog|
      puts "#{index}. #{dog.name}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection = gets.chomp
    
    selection_valid = check_valid_selection(options, selection)
  end

  shelter_update_dog_menu(shelter.dogs[selection.to_i - 1])
end

def shelter_update_dog_menu(dog)
  selection_valid = false
  options = ["1", "2", "3", "4"]

  while !selection_valid
    puts ""
    puts "What would you like to update?"
    puts "1. Name"
    puts "2. Age"
    puts "3. Breed"
    puts "4. Traits"
    puts "5. Main Menu"
    selection = gets.chomp
    
    if selection == "1"
      dog.update_name(get_dog_name)
    elsif selection == "2"
      dog.update_age(get_dog_age)
    elsif selection == "3"
      dog.update_breed(get_dog_breed)
    elsif selection == "4"
      dog.update_traits(get_dog_traits)
    elsif selection == "5"
      break
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def get_dog_name
  puts ""
  puts "Enter the dog's name"
  gets.chomp
end

def get_dog_age
  puts ""
  puts "Enter the dog's age"
  gets.chomp.to_i
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