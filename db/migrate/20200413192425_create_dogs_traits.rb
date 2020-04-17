class CreateDogsTraits < ActiveRecord::Migration[5.0]
  def change
    create_table :dogs_traits do |t|
      t.integer :dog_id
      t.integer :trait_id
    end
  end
end
