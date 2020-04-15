def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  login
end

def login
  puts ""
  puts "Please enter your username to log in or type \"quit\" to quit:"
  username_input = gets.chomp

  if username_input.downcase == "quit"
    return "quit"
  end

  if username_input.downcase == "shelter"
    shelter_login
    return nil
  end

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
    elsif selection == "2"
      break
    end
  end

  user
end

def shelter_login
  selection_valid = false
  selection = ""
  options = []

  while !selection_valid
    index = 1
    puts ""
    puts "Which shelter would you like to log in as?"
    puts ""
    Shelter.all.each do |shelter|
      puts "#{index}. #{shelter.name} at #{shelter.address}"
      options << index.to_s
      index += 1
    end
    puts ""
    selection  = gets.chomp

    selection_valid = check_valid_selection(options, selection)
  end

  shelter_menu(Shelter.all[selection.to_i - 1])
end