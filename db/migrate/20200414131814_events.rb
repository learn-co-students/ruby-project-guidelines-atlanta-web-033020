class Events < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :event_name
    end
  end
end
