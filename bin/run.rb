require_relative '../config/environment'

def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  user = login
  main_menu(user)
end

def login
  puts ""
  puts "Please enter your username to log in:"
  username_input = gets.chomp

  user = User.find_by(username: username_input)

  while !user
    puts ""
    puts "That user does not exist. Would you like to create the user #{username_input}?"
    puts "1. Yes"
    puts "2. No"
    selection = gets.chomp
    if selection == "1"
      user = User.create(username: username_input)
      LoggedInUser.username = user.username
    end
  end
  
  user
end

def main_menu(user)
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""

  # If not linked with a shelter, the user is specified as an adopter
  if user.is_foster_parent?
    foster_menu(user)
  else
    adopter_menu(user)
  end
end

def adopter_menu(user)
  selection_valid = false
  options = ["1", "2", "3"]

  puts "Select an option below:"
  puts ""
  puts "1. Update profile"
  puts "2. Adopt a dog"
  puts "3. Become a foster parent"
  puts ""

  while !selection_valid
    selection = gets.chomp

    if selection == "1"
      update_profile_menu(user)
    elsif selection == "2"
      search_dogs_menu(user)
    elsif selection == "3"
      select_shelter_menu(user)
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def update_profile_menu(user)
  selection_valid = false
  options = ["1", "2", "3"]

  while !selection_valid
    puts ""
    puts "What would you like to update?"
    puts "1. Traits"
    puts "2. Desired Dog Breed"
    puts "3. Desired Dog Age"
    puts ""
    selection = get.chomp

    if selection == "1"
      update_profile_menu(user)
    elsif selection == "2"
      search_dogs_menu(user)
    elsif selection == "3"
      select_shelter_menu(user)
    end

    selection_valid = check_valid_selection(options, selection)
  end
end

def check_valid_selection(options, selection)
  if options.include? selection
    true
  else
    puts "Invalid selection received. Please choose again."
    false
  end
end



# welcome

binding.pry