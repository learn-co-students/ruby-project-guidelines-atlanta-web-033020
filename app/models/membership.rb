class Membership < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :user
end