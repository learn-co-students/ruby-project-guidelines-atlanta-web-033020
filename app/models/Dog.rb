class Dog < ActiveRecord::Base
  belongs_to :shelter
  belongs_to :owner
  has_and_belongs_to_many :traits

  def self.dogs_without_owner
    Dog.all.select { |d| d.owner_id == nil }
  end

  def update_name(name)
    self.name = name
    self.save
  end

  def update_age(age)
    self.age = age
    self.save
  end

  def update_breed(breed)
    self.breed = breed
    self.save
  end

  def update_traits(traits)
    self.traits = []
    self.traits << traits
  end
end