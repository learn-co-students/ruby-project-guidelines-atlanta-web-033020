class Dog < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :owner
  has_and_belongs_to_many :traits
end