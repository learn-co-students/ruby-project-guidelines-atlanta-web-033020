class User_menu 

    def user_menu(prompt)
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Users", "Most Active", "Critics Only", "Back"])
            when "All Users"
                print_users(prompt,User.all)
                Gametracker.wait(prompt)
            when "Most Active"
                print_users(prompt,User.all_by_reviews)
                Gametracker.wait(prompt)
            when "Critics Only"
                print_users(prompt,User.critics)
                Gametracker.wait(prompt)
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def print_users(prompt, users, limit = nil)
        if !limit
            users.each do |user| 
                Gametracker.print_user(user,prompt)
            end
        else
            i=0
            limit.times do
                Gametracker.print_user(users[i],prompt)
                i += 1
            end
        end
        usernames = users.map{|u| u.username}
        usernames << "Exit"
        chosen_username = prompt.enum_select("Please choose a user to see thier reviews.", usernames)

        return if chosen_username == "Exit"

        chosen_index = usernames.find_index(chosen_username)
        puts "Here are #{chosen_username}'s reviews."
        Gametracker.print_reviews(prompt,Review.all_from_user(users[chosen_index]))
    end
end