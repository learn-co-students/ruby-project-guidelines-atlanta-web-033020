class Gametracker
    attr_reader :prompt, :delete
    attr_accessor :current_user

    def initialize
        @prompt = TTY::Prompt.new
        @delete = Delete.new
        @update = Update.new
        @review_menu = Review_menu.new
        @user_menu = User_menu.new
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

    def self.wait(prompt)
        prompt.ask("Enter any key to continue")
    end

    def print_review(review)
        puts "====================================================================================================================="
        puts "ID: #{review.id}   User: #{review.user.username}   Game: #{review.game.name}   Rating: #{review.score}   Comment: #{review.review_text}   Date: #{review.date}"
        puts ""
    end

    def self.print_review(review, prompt)
        puts "====================================================================================================================="
        puts "ID: #{review.id}   User: #{review.user.username}   Game: #{review.game.name}   Rating: #{review.score}   Comment: #{review.review_text}   Date: #{review.date}"
        puts ""
    end

    def self.print_reviews(prompt, reviews, limit = nil)
        if reviews.length == 0
            puts "Sorry you have no reviews"
            return
        end
        if !limit
            reviews.each do |review| 
                print_review(review,prompt)
            end
        else
            i=0
            limit.times do
                print_review(reviews[i],prompt)
                i += 1
            end
        end
    end

    def self.print_user(user,prompt)
        puts "====================================================================================================================="
        puts "ID: #{user.id}   User: #{user.username}   Critic?: #{user.critic?}"
        puts ""
    end

    def view_review_menu
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Reviews", "Most recent", "Highest Ratings", "My Reviews", "Back"])
            when "All Reviews"
                Review_viewer.print_reviews(prompt, Review.all)
                self.wait
            when "Most recent"
                Review_viewer.print_reviews(prompt, Review.most_recent, 10)
                self.wait
            when "Highest Ratings"
                Review_viewer.print_reviews(prompt, Review.all_by_rating, 10)
                self.wait
            when "My Reviews"
                Review_viewer.print_reviews(prompt,Review.all_from_user(current_user))
                self.wait
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def user_menu
        @user_menu.user_menu(prompt)
    end

    def review_menu
        @review_menu.review_menu(current_user,prompt)
    end

    def delete_menu
        delete.delete_menu(current_user, self.prompt)
    end

    def update_menu
        @update.update_menu(current_user,prompt)
    end

end