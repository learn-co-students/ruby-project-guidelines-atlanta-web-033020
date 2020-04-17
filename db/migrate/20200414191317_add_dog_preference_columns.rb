class AddDogPreferenceColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :dog_breed_preference, :string
    add_column :users, :dog_age_preference, :integer
  end
end
