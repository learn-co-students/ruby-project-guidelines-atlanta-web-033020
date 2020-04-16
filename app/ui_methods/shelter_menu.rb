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

  update_dog_shelter_menu(shelter.dogs[selection.to_i - 1])
end

def update_dog_shelter_menu(dog)
  puts ""
  choices = ["Name", "Age", "Breed", "Traits", "Back to Main Menu"]
  choice = PROMPT.select("What would you like to update?", choices)

  case choice
  when "Name"
    puts "Enter the dog's name"
    dog.update_name(get_dog_name)
  when "Age"
    puts "Enter dog age"
    dog.update_age(get_dog_age)
  when "Breed"
    puts "Select dog breed"
    dog.update_breed(get_dog_breed)
  when "Traits"
    puts "Select dog traits"
    dog.update_traits(select_traits)
  end
end