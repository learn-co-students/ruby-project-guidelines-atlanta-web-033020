class CreatePublisher < ActiveRecord::Migration[5.0]
  def change
    create_table :publishers do |t|
      t.string :name
    end
  end
end
