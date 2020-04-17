class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :shelter_id
      t.integer :user_id
    end
  end
end