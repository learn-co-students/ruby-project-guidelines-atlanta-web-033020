def logout
  LoggedInUser.user = nil
  LoggedInUser.shelter = nil
  LoggedInUser.type = nil
end