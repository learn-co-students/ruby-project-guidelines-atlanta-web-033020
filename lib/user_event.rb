class UserEvent < ActiveRecord::Base
    belongs_to :user
    belongs_to :event
    has_many :attendees, class_name: "User", foreign_key: :index_users_on_creator_id
    belongs_to :creator, class_name: "User"
end