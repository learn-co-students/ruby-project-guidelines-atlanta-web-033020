require 'faker'

Dog.destroy_all
Shelter.destroy_all
Trait.destroy_all
User.destroy_all
Membership.destroy_all

breeds = []

10.times do
  breeds << Faker::Creature::Dog.breed
end

50.times do
  User.create(username: Faker::Internet.username, address: Faker::Address.full_address)
end

10.times do
  Shelter.create(name: Faker::Creature::Dog.meme_phrase.capitalize + " Shelter", address: Faker::Address.full_address)
end

100.times do
  Dog.create(name: Faker::Creature::Dog.name, age: rand(0..15), breed: breeds.sample)
end

Trait.create(trait_name: "shy")
Trait.create(trait_name: "active")
Trait.create(trait_name: "lazy")
Trait.create(trait_name: "friendly")
Trait.create(trait_name: "playful")
Trait.create(trait_name: "always hungry")
Trait.create(trait_name: "happy")
Trait.create(trait_name: "chill")

# Assign random traits to dogs
Dog.all.each do |d|
  dog_traits = [] 
  traits_length = Trait.all.length
  rand(1..6).times do
    rand_trait = Trait.all[rand(0..traits_length - 1)]
    if !dog_traits.include? rand_trait
      dog_traits << rand_trait
      d.traits << rand_trait
    end
  end
end

# Assign random traits to users
User.all.each do |u|
  user_traits = [] 
  traits_length = Trait.all.length
  rand(1..6).times do
    rand_trait = Trait.all[rand(0..traits_length - 1)]
    if !user_traits.include? rand_trait
      user_traits << rand_trait
      u.traits << rand_trait
    end
  end
end