class LoggedInUser
  @@user = nil
  @@shelter = nil
  @@type = nil

  def self.user
    @@user
  end

  def self.user=(user)
    @@user = user
  end

  def self.shelter
    @@shelter
  end

  def self.shelter=(shelter)
    @@shelter = shelter
  end

  def self.type
    @@type
  end

  def self.type=(type)
    @@type = type
  end
end