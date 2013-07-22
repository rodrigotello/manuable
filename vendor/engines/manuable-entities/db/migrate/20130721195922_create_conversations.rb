class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :body, length: 1000
      t.integer :from_id
      t.integer :to_id
      t.integer :unread_by_id
      t.string :last_message, length: 1000

      t.timestamps
    end

    add_index :conversations, [:from_id, :to_id]
  end
end
