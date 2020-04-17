class Gametracker
    attr_reader :prompt
    attr_accessor :current_user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def welcome
        puts "================================="
        puts "      Welcome to GameTracker"
        puts "================================="
    end

    def login_or_register
        prompt.select("Please log in or register", ["Log in", "Register"])
    end

    def get_username
        possible_username = nil
        username_taken = true
        while username_taken do
            possible_username = prompt.ask("Please enter a username to be known by.")
            if User.all.find{|user| user.username == possible_username} == nil
                username_taken = false
            else
                puts "That username is taken please try again."
            end
        end  
        possible_username
    end

    def get_password
        password = ""
        password_reentered = "no match"

        while password != password_reentered do
            password = prompt.mask("Please enter a password")
            password_reentered = prompt.mask("Please re-enter your password.")
            if(password != password_reentered)
                puts ("The passwords did not match please try again")
            end
        end
        password
    end

    def register
        new_user_info = {}
        username_taken = true
        new_user_info[:name] = prompt.ask("Please enter your name.")
        new_user_info[:username] = self.get_username
        new_user_info[:password] = self.get_password
        new_user_info[:critic?] = prompt.yes?("Are you a employed critic?")

        current_user = User.create(new_user_info)
    end

    def find_username
        username_found = false
        found_user = nil
        while !username_found do
            possible_username = prompt.ask("Please enter your username")
            if possible_username == "exit"
                return nil
            elsif found_user = User.all.find{|user| user.username == possible_username}
                username_found = true
            else
                puts "Username not found please try again or type exit to return to the main menu"
            end
        end  
        found_user
    end

    def compare_password
        passwords_match = false

        3.times do
            test_password = prompt.mask("Please enter your password.")
            if test_password == self.current_user.password
                passwords_match = true
                break
            else
                puts "Password is not correct please try again."
            end
        end
        puts "Exceeded max number of tries returning to log in menu." unless passwords_match
        passwords_match
    end

    def login
        self.current_user = self.find_username
        return nil if current_user == nil
        return nil unless compare_password
    end

    def main_selection
        prompt.select("What would you like to do?",["View Games", "View Reviews", "View Users", "Review a game", "Delete a review", "Update a review", "Quit"])
    end

    def print_game(game)
        puts "====================================================================================================================="
        puts "ID: #{game.id}   Name: #{game.name}   Publisher: #{game.publisher}   Release Date: #{game.release_date}   Average Rating: #{game.average_review}"
        puts ""
    end

    def print_games(games, limit = nil)
        if !limit
            games.each do |game| 
                print_game(game)
            end
        else
            i=0
            limit.times do
                print_game(games[i])
                i += 1
            end
        end
    end

    def game_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Games", "Top 10", "Most Reviewed", "Back"])
            when "All Games"
                self.print_games(Game.all)
                self.wait
            when "Top 10"
                self.print_games(Game.all_by_rating, 10)
                self.wait
            when "Most Reviewed"
                self.print_game(Game.all_by_review_count.first)
                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def wait
        prompt.ask("Enter any key to continue")
    end

    def print_review(review)
        puts "====================================================================================================================="
        puts "ID: #{review.id}   User: #{review.user.username}   Game: #{review.game.name}   Rating: #{review.score}   Comment: #{review.review_text}   Date: #{review.date}"
        puts ""
    end

    def print_reviews(reviews, limit = nil)
        if !limit
            reviews.each do |review| 
                print_review(review)
            end
        else
            i=0
            limit.times do
                print_review(reviews[i])
                i += 1
            end
        end
    end

    def print_user(user)
        puts "====================================================================================================================="
        puts "ID: #{user.id}   User: #{user.username}   Critic?: #{user.critic?}"
        puts ""
    end

    def print_users(users, limit = nil)
        if !limit
            users.each do |user| 
                print_user(user)
            end
        else
            i=0
            limit.times do
                print_user(users[i])
                i += 1
            end
        end
    end

    def view_review_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Reviews", "Most recent", "Highest Ratings", "Back"])
            when "All Reviews"
                self.print_reviews(Review.all)
                self.wait
            when "Most recent"
                self.print_reviews(Review.most_recent, 10)
                self.wait
            when "Highest Ratings"
                self.print_reviews(Review.all_by_rating)
                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def user_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Users", "Most Active", "Critics Only", "Back"])
            when "All Users"
                self.print_users(User.all)
                self.wait
            when "Most Active"
                self.print_users(User.all_by_reviews)
                self.wait
            when "Critics Only"
                self.print_users(User.critics)
                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def game_select
        games_found = false
        while !games_found
            game_name = prompt.ask("Please type in a game name to search")
            game_arr = Game.all.select{|g| g.name.downcase.include?(game_name.downcase)}
            if game_arr == nil
                puts "Sorry no game found. Please Try Again"
            else
                games_found = true
            end
        end
        
    end

    def review_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to do?",["Find Game to Review", "Back"])
            when "Find Game to Review"
                game = game_select

                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def delete_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Users", "Most Active", "Critics Only", "Back"])
            when "All Users"
                self.print_users(User.all)
                self.wait
            when "Most Active"
                self.print_users(User.all_by_reviews)
                self.wait
            when "Critics Only"
                self.print_users(User.critics)
                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def update_menu

    end

end