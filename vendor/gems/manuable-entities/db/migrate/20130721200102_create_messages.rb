class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.text :body
      t.integer :conversation_id

      t.timestamps
    end

    add_index :messages, [:conversation_id]
  end
end
