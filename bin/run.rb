require_relative '../config/environment'

def main_menu(user)
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""
  puts "Select an option below:"

  user_type = user.type_of_user
  if user_type == "foster"
    foster_menu
  elsif user_type == "adopter"
    adopter_menu
  else
    new_user_menu
  end
end

def foster_menu

end

def adopter_menu
  
end

def new_user_menu
  puts "1. Become a Foster Parent"
  puts "2. Adopt a Dog Today!"
end

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
    create_user_input = gets.chomp
    if create_user_input == "1"
      user = User.create(username: username_input)
      LoggedInUser.username = user.username
    end
  end
  
  user
end

welcome