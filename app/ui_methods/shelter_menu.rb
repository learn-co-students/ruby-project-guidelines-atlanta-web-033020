def shelter_menu(shelter)
  choices = ["Update Shelter Name", "Update Shelter Address", "Add Dog", "Update Dog", "Logout"]
  choice = PROMPT.select("", choices)

  case choice
  when "Update Shelter Name"
    shelter_update_name_menu(shelter)
  when "Update Shelter Address"
    shelter_update_address_menu(shelter)
  when "Add Dog"
    shelter_add_dog_menu(shelter)
  when "Update Dog"
    shelter_select_dog_to_update_menu(shelter)
  when "Logout"
    logout
  end
end

def shelter_update_name_menu(shelter)
  puts ""
  puts "Enter the new shelter name"
  shelter.update_name(PROMPT.ask("Name:"))
end

def shelter_update_address_menu(shelter)
  puts ""
  puts "Enter the shelter address"
  shelter.update_address(PROMPT.ask("Address:"))
end

def shelter_add_dog_menu(shelter)
  name = get_dog_name
  age = get_dog_age
  breed = get_dog_breed
  traits = select_traits

  shelter.add_dog(name, age, breed, traits)
end

def shelter_select_dog_to_update_menu(shelter)
  dogs = shelter.dogs

  puts ""
  choice = PROMPT.select("Select which dog you would like to update") do |menu|
    dogs.each_with_index do |d, i|
      menu.choice "#{d.name} the #{d.breed}", i
    end
  end

  update_dog_shelter_menu(dogs[choice])
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