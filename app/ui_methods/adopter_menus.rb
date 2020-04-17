def adopter_menu(user)
  choices = ["View Profile", "Update Profile", "Adopt a Dog", "Become a Foster Parent", "Logout", "Delete Account"]
  choice = PROMPT.select("Select an option below:", choices)

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
  when "Delete Account"
    delete_account(user)
  end
end