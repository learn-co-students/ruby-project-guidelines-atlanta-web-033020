require_relative '../config/environment'
require_relative '../bin/cli.rb'

newCli = Cli.new
newCli.start_menu

puts "HELLO WORLD"

abort
