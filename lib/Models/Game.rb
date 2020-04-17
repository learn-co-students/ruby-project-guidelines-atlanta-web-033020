class Game < ActiveRecord::Base
    has_many :reviews
    belongs_to :publisher
    
end