require_relative '../config/environment'

def main_menu
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
end

def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  user = login
  main_menu
end

def login
  puts "Please enter your username to log in:"
  username_input = gets.chomp

  user = User.find_by(username: username_input)

  if !user
    puts "That user does not exist. Would you like to create the user #{username_input}?"
    puts "1. Yes"
    puts "2. No"
    create_user_input = gets.chomp
    if create_user_input == "1"
      user = User.create(username: username_input)
    else
      login
    end
  end

  LoggedInUser.username = user.username
  user
end

welcome