class Dog < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :owner
  has_and_belongs_to_many :traits

  def self.dogs_without_owner
    Dog.all.select { |d| d.owner_id == nil }
  end
end