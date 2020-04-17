require_relative '../config/environment'

gt = Gametracker.new

gt.welcome

while !gt.current_user do
    selection = gt.login_or_register

    case selection
    when "Register"
        gt.register
    when "Log in"
        gt.login
    end
end


binding.pry
