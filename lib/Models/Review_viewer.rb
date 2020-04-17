class Review_viewer

    def view_review_menu(current_user, prompt)
        stay_in_menu = true

        while stay_in_menu do
            case prompt.select("What would you like to see?",["All Reviews", "Most recent", "Highest Ratings", "My Reviews", "Back"])
            when "All Reviews"
                Review_viewer.print_reviews(prompt,Review.all)
                Gametracker.wait(prompt)
            when "Most recent"
                Review_viewer.print_reviews(prompt,Review.most_recent, 10)
                Gametracker.wait(prompt)
            when "Highest Ratings"
                Review_viewer.print_reviews(prompt,Review.all_by_rating, 10)
                Gametracker.wait(prompt)
            when "My Reviews"
                seReview_viewerlf.print_reviews(prompt,Review.all_from_user(current_user))
                Gametracker.wait(prompt)
            when "Back"
                stay_in_menu = false
            end
        end
    end

    def self.print_reviews(prompt, reviews, limit = nil)
        if reviews.length == 0
            puts "Sorry you have no reviews"
            return
        end
        if !limit
            reviews.each do |review| 
                print_review(prompt, review)
            end
        else
            i=0
            limit.times do
                print_review(prompt, reviews[i])
                i += 1
            end
        end
    end

    def self.print_review(prompt, review)
        puts "====================================================================================================================="
        puts "ID: #{review.id}   User: #{review.user.username}   Game: #{review.game.name}   Rating: #{review.score}   Comment: #{review.review_text}   Date: #{review.date}"
        puts ""
    end

    
end