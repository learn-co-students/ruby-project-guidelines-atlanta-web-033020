class UserEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :user_events do |t|
      t.belongs_to :user
      t.belongs_to :event
      t.string :date
    end
  end
end
