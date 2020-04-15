def foster_menu(user)
  selection_valid = false
  options = ["1", "2", "3", "4", "5"]

  puts "Select an option below:"
  puts ""
  puts "1. Update profile"
  puts "2. Adopt a dog"
  puts "3. Adopt a shelter dog"
  puts "4. Manage fostered dogs"
  puts "5. Join another shelter"
  puts "6. Logout"

  while !selection_valid
    selection = gets.chomp

    if selection == "1"
      update_profile_menu(user)
    elsif selection == "2"
      foster_adopt_dog_menu(user)
    elsif selection == "3"
      adopt_from_shelter_menu(user)
    elsif selection == "4"
      manage_fostered_dogs_menu(user)
    elsif selection == "5"
      join_shelter_menu(user)
    elsif selection == "6" || selection.downcase == "quit"
      logout
      return true
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def foster_adopt_dog_menu(user)
  selection_valid = false
  options = ["1", "2"]

  puts "From where would you like to adopt a dog?"
  puts ""
  puts "1. Shelter"
  puts "2. Other Foster"

  while !selection_valid
    selection = gets.chomp

    if selection == "1"
      adopt_from_shelter_menu(user)
    elsif selection == "2"
      adopt_from_foster_menu(user)
    end

    selection_valid = check_valid_selection(options, selection)
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
  selection_valid = false
  options = []
  
  dogs = user.dogs

  puts "Select a dog to update"
  puts ""
  dogs.each_with_index do |d, i|
    puts "#{i + 1}. #{d.name} the #{d.breed}"
    options << (i + 1).to_s
  end

  puts "#{dogs.length + 1}. Quit"

  while !selection_valid do
    selection = gets.chomp
    if selection == "quit" || selection == (dogs.length + 1).to_s
      break
    end
    selection_valid = check_valid_selection(options, selection)
  end

  if selection != "quit" && selection != (dogs.length + 1).to_s
    update_dog_menu(dogs[selection.to_i - 1])
  end
end