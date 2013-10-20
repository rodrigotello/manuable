class CreateEventsUsers < ActiveRecord::Migration
  def up
    create_table :events_users, id: false do |t|
      t.integer :user_id
      t.integer :event_id
    end
  end

  def down
    drop_table :events_users
  end
end
