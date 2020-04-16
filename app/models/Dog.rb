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

  def update_traits(trait_strings)
    self.traits = []
    traits = trait_strings.map { |ts| Trait.find_by(trait_name: ts) }
    self.traits << traits
  end

  def self.adoptable_dogs
    Dog.all.select { |d| d.adoption_ready}
  end

  def compute_dog_score(user)
    dog_trait_ids = self.traits.map { |t| t.id }
    user_trait_ids = user.traits.map { |t| t.id }
    traits_score = dog_trait_ids.length + user_trait_ids.length - ((dog_trait_ids & user_trait_ids).length * 2)
    
    if user.dog_age_preference != nil
      age_score = (self.age - user.dog_age_preference).abs
    else
      age_score = 0
    end
    
    if user.dog_breed_preference != nil
      breed_score = self.breed == user.dog_breed_preference ? 0 : 5
    else
      breed_score = 0
    end
    
    traits_score + age_score + breed_score
  end

  def make_adoption_ready
    self.adoption_ready = true
    self.save
  end
end