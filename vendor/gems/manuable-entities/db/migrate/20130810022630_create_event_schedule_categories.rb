class CreateEventScheduleCategories < ActiveRecord::Migration
  def change
    create_table :event_schedule_categories do |t|
      t.string :name
      t.integer :event_id

      t.timestamps
    end
  end
end
