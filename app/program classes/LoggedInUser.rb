class LoggedInUser
  @@username

  def self.username
    @@username
  end

  def self.username=(username)
    @@username = username
  end
end