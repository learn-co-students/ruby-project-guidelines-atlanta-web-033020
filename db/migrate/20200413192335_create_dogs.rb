class CreateDogs < ActiveRecord::Migration[5.0]
  def change
    create_table :dogs do |t|
      t.string :name
      t.integer :age
      t.string :breed
      t.boolean :adoption_ready, null: false, default: false
      t.integer :shelter_id
      t.integer :owner_id
    end
  end
end
