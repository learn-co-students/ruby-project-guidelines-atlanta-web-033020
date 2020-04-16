def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  login_or_quit
end

def login_or_quit
  choices = ["Login","Quit"]
  choice = PROMPT.select("Select an option", choices)

  case choice
  when "Login"
    login
  when "Quit"
    "quit"
  end
end

def login
  puts ""
  puts "Please enter your username to log in"
  username_input = PROMPT.ask("Username:", required: true)

  if username_input.downcase == "shelter"
    LoggedInUser.type = "shelter"
    shelter_login
    return nil
  else
    LoggedInUser.type = "user"
  end

  user = LoggedInUser.user = User.find_by(username: username_input)
  
  if !user
    puts ""
    choices = ["Yes", "No"]
    choice = PROMPT.select("That user does not exist. Would you like to create the user #{username_input}?", choices)
    
    if choice == "Yes"
      user = User.create(username: username_input)
      LoggedInUser.user = user
    end
  end
end

def shelter_login
  choice = PROMPT.select("Which shelter would you like to log in as?") do |menu|
    Shelter.all.each_with_index do |s, i|
      menu.choice "#{s.name} at #{s.address}", i
    end
  end

  LoggedInUser.shelter = Shelter.all[choice]
end