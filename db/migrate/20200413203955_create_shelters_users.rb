class CreateSheltersUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :shelter_users do |t|
      t.integer :shelter_id
      t.integer :user_id
      t.boolean :is_foster_parent
    end
  end
end
