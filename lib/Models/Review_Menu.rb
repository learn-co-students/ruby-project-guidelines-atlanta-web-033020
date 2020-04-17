class Review_menu

    def review_game(current_user,prompt)
        games_found = false
        game_selected = false
        game_name = nil
        game = nil
        game_arr = []
        game_name_arr = []
        while !games_found do
            game_name = prompt.ask("Please type in a game name to search")
            game_arr = Game.all.select{|g| g.name.downcase.include?(game_name.downcase)}
            if game_arr.length == 0
                puts "Sorry no game found. Please Try Again"
            else
                games_found = true
            end
        end
        game_name_arr = game_arr.map{|g|g.name}
        puts "============================================================================"

        game = game_arr[game_name_arr.find_index(prompt.enum_select("Please select the game to review", game_name_arr))]

        user_reviews = Review.all_from_user(current_user)

        if user_reviews.find{|r| r.game_id == game.id}
            puts "Sorry you have already reviewed this game"
        else
            score = prompt.ask("You chose #{game.name}. Please enter a score.").to_i
            text = prompt.ask("You gave it an #{score}. Please enter a description")

            puts "Thank you for the review"
            puts "Your review is:"
            Gametracker.print_review(Review.create({game_id: game.id, user_id: current_user.id, date: Time.now.strftime("%m/%d/%Y"), score: score, review_text: text}), prompt)
        end
    end

    def review_menu(current_user,prompt)
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to do?",["Find Game to Review", "Back"])
            when "Find Game to Review"
                review_game(current_user,prompt)
                Gametracker.wait(prompt)
            when "Back"
                stay_in_menu = false
            end
        end
    end
    
end