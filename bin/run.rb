require_relative '../config/environment'

quit_program = false
while !quit_program
  # Welcome User
  while !LoggedInUser.user && !LoggedInUser.shelter do
    if welcome == "quit"
      quit_program = true
      break
    end
  end

  # Cycle main menu until quit by user
  while LoggedInUser.user || LoggedInUser.shelter do
    main_menu
  end
end