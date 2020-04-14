class User < ActiveRecord::Base
  has_many :shelter_users
  has_many :shelters, through: :shelter_users
  has_many :dogs, :foreign_key => 'owner_id'
  has_and_belongs_to_many :traits

  def is_adopter?

  end

  def is_foster?

  end

  def type_of_user
    if self.is_adopter?
      "adopter"
    elsif self.is_foster?
      "foster"
    else
      nil
    end
  end
end