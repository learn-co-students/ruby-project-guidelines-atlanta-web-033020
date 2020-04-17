require 'bundler'
Bundler.require

ActiveRecord::Base.logger = nil
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
PROMPT = TTY::Prompt.new

require_all 'lib'
require_all 'app'
