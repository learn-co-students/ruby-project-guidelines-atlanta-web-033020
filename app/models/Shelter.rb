class Shelter < ActiveRecord::Base
  has_many :dogs
  has_many :shelter_users
  has_many :users, through: :shelter_users

  def create_dog(name, age, breed, traits)
    Dog.new(name, age, breed)
  end

  def update_dog(dog, name, age, breed, traits)
    dog = find_by(id: dog.id)
    dog.name = name
    dog.age = age
    dog.breed = breed
    dog.save
  end
end