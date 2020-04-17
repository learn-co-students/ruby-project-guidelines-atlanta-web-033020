class CreateUsersTraits < ActiveRecord::Migration[5.0]
  def change
    create_table :traits_users do |t|
      t.integer :trait_id
      t.integer :user_id
    end
  end
end
