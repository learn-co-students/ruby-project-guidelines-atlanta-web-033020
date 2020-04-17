class User < ActiveRecord::Base
  has_many :memberships
  has_many :shelters, through: :memberships
  has_many :dogs, :foreign_key => 'owner_id'
  has_and_belongs_to_many :traits

  def is_foster_parent?
    self.memberships.length > 0 ? true : false
  end

  def update_traits(trait_strings)
    self.traits = []
    traits = trait_strings.map { |ts| Trait.find_by(trait_name: ts) }
    self.traits << traits
  end

  def update_address(address)
    self.address = address
    self.save
  end

  def update_breed_preference(breed)
    self.dog_breed_preference = breed
    self.save
  end

  def update_dog_age_preference(age)
    self.dog_age_preference = age
    self.save
  end

  def find_compatible_dogs
    dogs = []
    Dog.adoptable_dogs.each do |d|
      if d.owner_id != self.id
        dogs << { dog: d, dog_score: d.compute_dog_score(self) }
      end
    end
    ranked_dogs = dogs.sort_by { |dog_hash| dog_hash[:dog_score] }
  end

  def adopt_shelter_dog(dog)
    dog.adoption_ready = false
    dog.save
    self.dogs << dog
  end

  def adopt_dog(dog)
    dog.destroy
  end

  def join_shelter(shelter)
    Membership.create(user_id: self.id, shelter_id: shelter.id)
  end

  def delete_account
    self.dogs.each do |d| 
      d.adoption_ready = false
      d.owner_id = nil
      d.save
    end
    memberships = self.memberships.select { |m| m.user = self }
    memberships.each { |m| m.destroy }
    self.destroy
  end
end