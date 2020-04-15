def welcome
  puts "============================="
  puts "|  Wecome to Furry Finder!  |"
  puts "============================="
  login
end

def login
  puts ""
  puts "Please enter your username to log in or type \"quit\" to quit:"
  username_input = PROMPT.ask("Username:")

  if username_input.downcase == "quit"
    return "quit"
  end

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
    Shelter.all.each_with_index do |shelter, index|
      menu.choice shelter.name, index
    end
  end

  LoggedInUser.shelter = Shelter.all[choice]
end