class CreateNotifications < ActiveRecord::Migration
  def up
    create_table :notifications do |t|
      t.integer :from_id
      t.integer :to_id
      t.integer :comment_id
      t.string  :code
      t.boolean :read, default: false
      t.timestamps
    end
  end

  def down
    drop_table :notifications

  end
end
