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
      explore_shelter_dogs_menu(user)
    elsif selection == "4"
      manage_fostered_dogs_menu(user)
    elseif selection == "5"
      join_shelter(user)
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