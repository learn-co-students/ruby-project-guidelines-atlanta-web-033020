class Delete
    def delete_menu(current_user, prompt)
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to do?",["Select a Review to Delete", "Back"])
            when "Select a Review to Delete"
                delete_review(current_user,prompt)
                Gametracker.wait(prompt)
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def delete_review(current_user, prompt)
        reviews = Review.all_from_user(current_user)
        if reviews == nil
            puts "Sorry you have no reviews."
            return
        end
        game_name_arr = reviews.map{|r|r.game.name}
        chosen_game = prompt.enum_select("Please select a review to delete", game_name_arr)
        reviews[game_name_arr.find_index(chosen_game)].destroy
    end
end
