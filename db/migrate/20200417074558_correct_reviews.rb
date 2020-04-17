class CorrectReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :reviewer_id
    add_column :reviews, :user_id, :integer
  end
end
