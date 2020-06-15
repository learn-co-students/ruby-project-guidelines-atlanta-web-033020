class Review < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    
    def self.all_by_rating
        self.all.sort_by{|r| r.score}.reverse
    end

    def self.most_recent
        self.all.sort_by{|r| Date.strptime(r.date, '%m/%d/%Y')}.reverse
    end

    def self.all_from_user(user)
        self.all.select{|r| r.user_id == user.id}
    end
end