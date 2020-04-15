class User < ActiveRecord::Base
  has_many :memberships
  has_many :shelters, through: :memberships
  has_many :dogs, :foreign_key => 'owner_id'
  has_and_belongs_to_many :traits

  def is_foster_parent?
    if self.memberships.length > 0
      self.memberships.each do |m|
        if m.is_foster_parent
          return true
        end
      end
    end
    return false
  end

  def update_traits(trait_nums)
    self.traits = []
    trait_nums = trait_nums.map { |t| t.strip } # remove white space
    traits = trait_nums.map { |t| Trait.all[t.to_i - 1] } # convert to trait instance
    self.traits << traits
  end

  def update_address(address)
    self.address = address
    self.save
  end

  def update_breed_preference(dog_breeds, breed)
    self.dog_breed_preference = dog_breeds[breed.to_i - 1]
    self.save
  end

  def update_dog_age_preference(age)
    self.dog_age_preference = age
    self.save
  end
end