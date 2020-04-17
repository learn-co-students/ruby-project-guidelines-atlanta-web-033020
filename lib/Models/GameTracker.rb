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
            elsif User.all.find{|user| user.username == possible_username} == nil
                username_found = true
                found_user = user
            else
                puts "Username not found please try again or type exit to return to the main menu"
            end
        end  
        found_user
    end

    def compare_password
        
    end

    def login
        current_user = self.find_username
        return nil if current_user == nil



    end
end