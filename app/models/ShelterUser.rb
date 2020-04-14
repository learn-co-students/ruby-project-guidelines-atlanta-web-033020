class ShelterUser < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :user
end