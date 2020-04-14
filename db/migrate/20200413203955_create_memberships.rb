class CreateMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships do |t|
      t.integer :shelter_id
      t.integer :user_id
      t.boolean :is_foster_parent, null: false, default: false
    end
  end
end