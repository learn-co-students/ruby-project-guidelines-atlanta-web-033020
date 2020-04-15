require_relative '../config/environment'

# Welcome User
user = nil
while !user && user != "quit" do
  user = welcome
end

# Cycle main menu until quit by user
while true && user != "quit" do
  if main_menu(user) == true
    break
  end
end