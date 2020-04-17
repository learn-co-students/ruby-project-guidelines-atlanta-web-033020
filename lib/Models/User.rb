class User < ActiveRecord::Base
    has_many :reviews
    
    def self.all_by_reviews
        self.all.sort_by{|u| u.reviews.length}.reverse
    end

    def self.critics
        self.all.select{|u| u.critic?}
    end
end