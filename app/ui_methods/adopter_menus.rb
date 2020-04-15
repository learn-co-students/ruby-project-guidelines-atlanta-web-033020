def adopter_menu(user)
  choice = PROMPT.select("Select an option below:") do |menu|
    menu.choice "Update Profile", 0
    menu.choice "Adopt a Dog", 1
    menu.choice "Become a Foster Parent", 2
    menu.choice "Logout", 3
  end

  case choice
  when 0
    update_profile_menu(user)
  when 1
    adopt_from_foster_menu(user)
  when 2
    join_shelter_menu(user)
  when 3
    logout
  end
end