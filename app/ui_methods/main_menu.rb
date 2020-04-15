def main_menu
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""

  # If not linked with a shelter, the user is specified as an adopter
  if LoggedInUser.type == "shelter"
    shelter_menu(LoggedInUser.shelter)
  else
    if LoggedInUser.user.is_foster_parent?
      foster_menu(LoggedInUser.user)
    else
      adopter_menu(LoggedInUser.user)
    end
  end
  
end