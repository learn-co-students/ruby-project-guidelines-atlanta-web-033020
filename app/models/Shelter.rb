class Shelter < ActiveRecord::Base
  has_many :dogs
  has_many :memberships
  has_many :users, through: :memberships

  def update_name(name)
    self.name = name
    self.save
  end

  def update_address(address)
    self.address = address
    self.save
  end

  def add_dog(name, age, breed, traits)
    dog = Dog.create(name: name, age: age, breed: breed)
    dog.traits << traits
    self.dogs << dog
  end

  def update_dog(dog, name, age, breed, traits)
    dog = find_by(id: dog.id)
    dog.name = name
    dog.age = age
    dog.breed = breed
    dog.save
  end

  def self.shelters_not_joined(user)
    Shelter.all - user.shelters
  end

  def unfostered_dogs
    self.dogs.select { |dog| dog.owner_id == nil }
  end
end