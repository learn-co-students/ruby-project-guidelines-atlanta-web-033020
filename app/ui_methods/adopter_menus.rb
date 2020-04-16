def adopter_menu(user)
  choices = ["View Profile", "Update Profile", "Adopt a Dog", "Become a Foster Parent", "Logout"]
  choice = PROMPT.select("Select an option below:") do |menu|
    menu.choice "Update Profile"
    menu.choice "Adopt a Dog"
    menu.choice "Become a Foster Parent", 2
    menu.choice "Logout", 3
  end

  case choice
  when "View Profile"
    view_profile(user)
  when "Update Profile"
    update_profile_menu(user)
  when "Adopt a Dog"
    adopt_from_foster_menu(user)
  when "Become a Foster Parent"
    join_shelter_menu(user)
  when "Logout"
    logout
  end
end