class UpdateGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :publisher_id, :integer
  end
end
