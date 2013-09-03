class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :external_id
      t.string :client
      t.timestamp :start_time
      t.timestamp :end_time
      t.integer :sequence
      t.float :latitude
      t.float :longitude
      t.boolean :recurs

    end
  end
end
