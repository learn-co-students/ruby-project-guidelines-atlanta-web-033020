class UpdateUser2 < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :text
  end
end
