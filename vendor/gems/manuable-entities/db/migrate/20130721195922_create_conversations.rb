class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.text :body
      t.integer :from_id
      t.integer :to_id
      t.integer :unread_by_id
      t.text :last_message

      t.timestamps
    end

    add_index :conversations, [:from_id, :to_id]
  end
end
