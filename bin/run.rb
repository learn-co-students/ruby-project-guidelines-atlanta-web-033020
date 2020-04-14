require_relative '../config/environment'

def main_menu
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""    
end

def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  user = login
  main_menu
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