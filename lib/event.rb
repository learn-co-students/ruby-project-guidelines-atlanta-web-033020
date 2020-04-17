class Event < ActiveRecord::Base
    has_many :user_event
    has_many :user, through: :user_event
    # def newUser(date, user)
    #     user_instance = User.find_or_create_by(user_name: user)
    #     UserEvent.update(date: date, user: user_instance, event: self)
    # end

    def self.event_instance_with_names(user)
        b = Hash.new
        user.user_event.each do |instance|
            b["#{instance.event.event_name} at #{instance.date}"] = instance
        end
        b
    end

    def self.all_event_instance_with_names
        c = Hash.new
        UserEvent.all.each do |instance|
            c["#{instance.event.event_name} at #{instance.date}"] = instance
        end
        c
    end

    def self.event_instances_without_user(user)
        self.all_event_instance_with_names.select do |k, v|
            v.user != user
        end
    end
end