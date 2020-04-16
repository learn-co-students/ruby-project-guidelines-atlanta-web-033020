def foster_menu(user)
  choices = ["Update Profile", "Adopt a Dog", "Adopt a Shelter Dog",
    "Manage Foster Dogs","Join Another Shelter", "Logout"]
  choice = PROMPT.select("Selection an option below:", choices)

  case choice
  when "Update Profile"
    update_profile_menu(user)
  when "Adopt a Dog"
    foster_adopt_dog_menu(user)
  when "Adopt a Shelter Dog"
    adopt_from_shelter_menu(user)
  when "Manage Foster Dogs"
    manage_fostered_dogs_menu(user)
  when "Join Another Shelter"
    join_shelter_menu(user)
  when "Logout"
    logout
  end
end

def foster_adopt_dog_menu(user)
  puts ""
  choices = ["Shelter", "Other Foster"]
  choice = PROMPT.select("From where would you like to adopt a dog?", choices)
  
  case choice
  when "Shelter"
    adopt_from_shelter_menu(user)
  when "Other Foster"
    adopt_from_foster_menu(user)
  end
end

def adopt_from_shelter_menu(user)
  selection_valid = false
  options = []
  dogs = []
  selection = nil

  user.shelters.each { |shelter| dogs += shelter.unfostered_dogs }
  dogs.each_with_index { |d, i| options << (i + 1).to_s}

  show_list_of_dogs(dogs)

  if dogs.empty?
    puts "Looks like there are no dogs in your shelter(s)!"
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
    
      puts "#{new_best_friend.name} will make a lovely addition to your home!"
    end
  end

  puts "Press enter to return to the main menu."
  gets.chomp
end

def show_list_of_dogs(dogs)
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
end

def manage_fostered_dogs_menu(user)
  puts ""
  dogs = user.dogs

  choice = PROMPT.select("Select a dog to update") do |menu|
    dogs.each_with_index do |d, i|
      menu.choice "#{d.name} the #{d.breed}", i
    end
  end

  update_dog_foster_menu(dogs[choice])
end

def update_dog_foster_menu(dog)
  puts ""
  choices = ["Name", "Age", "Breed", "Traits", "Make Adoption Ready", "Back to Main Menu"]
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
  when "Make Adoption Ready"
    make_adoption_ready_menu(dog)
  end
end

def make_adoption_ready_menu(dog)
  choices = ["Yes", "No"]
  choice = PROMPT.select("Confirm #{dog.name} is ready for a new family!", choices)
  if choice == "Yes"
    dog.make_adoption_ready
  end
end