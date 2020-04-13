class DeleteShelterIdColumnFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :shelter_id, :integer
  end
end
