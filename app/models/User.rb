class User < ActiveRecord::Base
  has_many :shelter_users
  has_many :shelters, through: :shelter_users
  has_many :dogs, :foreign_key => 'owner_id'
  has_and_belongs_to_many :traits
end