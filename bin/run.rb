require_relative '../config/environment'

gt = Gametracker.new
continue_running = true

#binding.pry

gt.welcome

while !gt.current_user do
    selection = gt.login_or_register

    case selection
    when "Register"
        gt.register
    when "Log in"
        gt.login
    end
end


while continue_running do
    selection = gt.main_selection

    case selection
    when "View Games"
        gt.game_menu
        
    when "View Reviews"
        gt.view_review_menu
        
    when "View Users"
        gt.user_menu
        
    when "Review a game"
        gt.review_menu
        
    when "Delete a review"
        gt.delete_menu
        
    when "Update a review"
        gt.update_menu
        
    when "Quit"
        continue_running = false
        
    end  
end



