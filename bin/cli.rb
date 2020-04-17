require 'pry'

class Cli

    attr_accessor :user, :user_hash, :event, :all_hash
    attr_reader :tty

    def initialize
        @user = nil
        @user_hash = nil
        @all_hash = nil
        @tty = TTY::Prompt.new
    end

    def start_menu
        main_menu = tty.select("Are you a new or returning user?") do |menu|
            menu.enum '.'
            menu.choice 'New User', 1
            menu.choice 'Current User', 2
            menu.choice 'View Current Users', 3
            menu.choice 'Exit', 4
        end
        if main_menu == 3
            @tty.say(User.all_users)
            @tty.keypress("Here are all the current users on file. Press any key to go back to the main menu")
            start_menu()
        else
            second_menu(main_menu)
        end
    end

    def second_menu(main_menu)
        if main_menu == 1
            newUser = @tty.ask("What would you like your username to be?") do |q|
                q.required true
            end
            @user = User.create(user_name: newUser)
            @user_hash = Event.event_instance_with_names(@user)
        elsif main_menu == 2
            oldUser = @tty.ask("What is your username?") do |q|
                q.required true
            end
            a = User.find_by(user_name: oldUser)
            if a
                @user = a
                @user_hash = Event.event_instance_with_names(@user)
            else
                prompt_2_Answer = @tty.select("That doesn't seem to be an old user. Would you like to try again?") do |menu|
                    menu.enum '.'
                    menu.choice 'Try Again', 1
                    menu.choice 'Go Back', 2
                end
                if prompt_2_Answer == 1
                    second_menu(main_menu)
                else
                    start_menu()
                end
            end
        else
            abort
        end
        third_menu()
    end

    def third_menu()
        user_input = @tty.select("What would you like to do #{@user.user_name}?") do |menu|
            menu.enum '.'
            menu.choice 'See My Events', 1
            menu.choice 'Make a New Event', 2
            menu.choice 'Join an Existing Event', 3, disabled: '>> Not Functioning Yet <<'
            menu.choice 'Remove My Account', 4
            menu.choice 'Log Out', 5
        end
        if user_input == 1
            user_events()
        elsif user_input == 2
            make_new_event()
        elsif user_input == 3
            join_existing_event()
        elsif user_input == 4
            confirmation_input = @tty.select("Are you sure?") do |menu|
                menu.enum '.'
                menu.choice 'Yes I am sure', 1
                menu.choice 'No I am not sure', 2
            end
            if confirmation_input == 1
                delete_user_account()
            else
                third_menu()
            end
        else
            start_menu()
            @user = nil
        end
    end

    def join_existing_event()
        @all_hash = Event.event_instances_without_user(@user)
        event = @tty.select("What event would you like to join?", @all_hash)

        binding.pry
    end

    def make_new_event()
        new_event = @tty.ask("What is the name of the new event?") do |q|
            q.required true
        end
        event = Event.create(event_name: new_event)
        new_date = @tty.ask("What is the date for #{new_event}?") do |q|
            q.required true
        end
        party = UserEvent.create(date: new_date, user: @user, event: event)
        @tty.keypress("The event titled #{party.event.event_name} at #{party.date} has been successfully created for #{@user.user_name}. You will now be returned to the previous menu.")
        @user = User.find(@user.id)
        third_menu()
    end

    def delete_user_account()
        @tty.keypress("The user #{@user.user_name} has been removed from the system.")
        @user.delete()
        start_menu()
    end

    def user_events
        if @user.event_names_on_user.empty?
            @tty.keypress("There are no Events for you, #{@user.user_name}. You will now be moved back to the previous menu.")
            third_menu()
        else
            event_names = @user_hash.map do |k, v|
                k
            end
            @tty.say(event_names)
        end
        input_for_prompt = @tty.select("What would you like to do?") do |menu|
            menu.enum '.'
            menu.choice 'Edit an Event', 1
            menu.choice 'Delete an Event', 2
            menu.choice 'Go back', 3
        end
        if input_for_prompt == 1
            edit_event()
        elsif input_for_prompt == 2
            delete_event()
        else
            third_menu()
        end
    end

    def edit_event
        event = @tty.select("What Event Would You Like to Edit?", @user_hash)
        option = @tty.select("What Part of the Event Would You Like to Edit?") do |menu|
            menu.enum '.'
            menu.choice 'Date', 1
            menu.choice 'Event Name', 2
            menu.choice 'Go Back', 3
        end
        if option == 1
            newDate = @tty.ask("What is the new date for this Event?") do |q|
                q.required true
            end
            event.date = newDate
            event.save
            @tty.keypress("The new date for #{event.event.event_name} is #{event.date}. Press any key to return to the Previous Menu")
            user_events()
        elsif option == 2
            newName = @tty.ask("What is the new name for this Event?") do |q|
                q.required true
            end
            event.event.event_name = newName
            event.event.save
            @tty.keypress("The new name for this event is #{event.event.event_name}")
            user_events()
        else
            user_events()
        end
    end

    def delete_event()
        event = @tty.select("What event would you like to delete?", @user_hash)
        @tty.keypress("The event #{event.event.event_name} has been deleted for #{@user.user_name}. You will now be returned to the previous menu.")
        event.delete
        @user = User.find(@user.id)
        @user_hash = Event.event_instance_with_names(@user)
        user_events()
    end
end
