class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :date
      t.integer :score
      t.string :review_text
      t.integer :game_id
      t.integer :reviewer_id
    end
  end
end
