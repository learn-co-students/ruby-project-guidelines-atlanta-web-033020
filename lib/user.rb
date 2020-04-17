class User < ActiveRecord::Base
    has_many :user_event
    has_many :event, through: :user_event
    has_many :attendees, class_name: "User", foreign_key: "index_users_on_creator_id"
    belongs_to :creator, class_name: "User"

    def newEvent(date, event)
        event_instance = Event.create(event_name: event)
        UserEvent.create(date: date, user: self, event: event_instance)
    end

    def joinEvent(date, event)
        event_instance = Event.find_by(event_name: event)
        UserEvent.create(date: date, user: self, event: event_instance)
    end

    def event_names_on_user
        self.user_event.map do |instance|
            instance.event.event_name
        end
    end

    def self.all_users
        self.all.map do |instance|
            instance.user_name
        end
    end
end