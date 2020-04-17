class Update

    def update_menu(current_user,prompt)
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to do?",["Select a Review to Update", "Back"])
            when "Select a Review to Update"
                update_review(current_user,prompt)
                Gametracker.wait(prompt)
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def update_review(current_user,prompt)
        reviews = Review.all_from_user(current_user)
        if reviews == nil
            puts "Sorry you have no reviews."
            return
        end
        game_name_arr = reviews.map{|r|r.game.name}
        chosen_game = prompt.enum_select("Please select a review to delete", game_name_arr)

        review = reviews[game_name_arr.find_index(chosen_game)]

        review.score = prompt.ask("Please enter a new score")
        review.review_text = prompt.ask("You gave it an #{review.score}. Please enter a description")
        review.save
        puts "Thank you, your new review is:"
        Gametracker.print_review(review, prompt)

    end
    
end