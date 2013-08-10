class CreateEventSchedules < ActiveRecord::Migration
  def change
    create_table :event_schedules do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :name
      t.integer :event_schedule_category_id
      t.integer :event_id

      t.timestamps
    end
  end
end
