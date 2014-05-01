class CreateEventRequests < ActiveRecord::Migration
  def change
    create_table :event_requests do |t|
      t.integer :event_id
      t.integer :user_id
      t.boolean :accepted, default: nil

      t.timestamps
    end
  end
end
