def main_menu(user)
  puts ""
  puts "============================="
  puts "|         Main Menu         |"
  puts "============================="
  puts ""

  # If not linked with a shelter, the user is specified as an adopter
  if user.is_foster_parent?
    foster_menu(user)
  else
    adopter_menu(user)
  end
end