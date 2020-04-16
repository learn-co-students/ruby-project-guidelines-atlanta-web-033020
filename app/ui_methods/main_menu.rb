def main_menu
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""

  # If not linked with a shelter, the user is specified as an adopter
  if LoggedInUser.type == "shelter"
    # Refresh shelter instance
    LoggedInUser.shelter = Shelter.find_by(id: LoggedInUser.shelter.id)
    if LoggedInUser.shelter == nil
      logout
    else
      shelter_menu(LoggedInUser.shelter)
    end
  else
    # Refresh user instance
    LoggedInUser.user = User.find_by(id: LoggedInUser.user.id)
    if LoggedInUser.user == nil
      logout
    else
      if LoggedInUser.user.is_foster_parent?
        foster_menu(LoggedInUser.user)
      else
        adopter_menu(LoggedInUser.user)
      end
    end
  end
  
end