class Game < ActiveRecord::Base
    has_many :reviews
    belongs_to :publisher
    
    def ratings
        self.reviews.map{|review| review.score}
    end

    def average_review
        self.ratings.sum.to_f/self.reviews.length
    end

    def self.all_by_rating
        Game.all.sort_by{|game| game.average_review}.reverse
    end

    def self.all_by_review_count
        Game.all.sort_by{|game| game.reviews.length}.reverse
    end
end