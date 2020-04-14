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
end