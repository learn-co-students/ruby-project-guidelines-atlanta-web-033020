class Publisher < ActiveRecord::Base
    has_many :games
    
    def games
        Game.all.select{|game| game.publisher_id == self.id}
    end

    def games_by_rating
        self.games.sort_by{|game|game.average_review}
    end
end