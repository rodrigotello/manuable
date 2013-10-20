class CreateEventProducts < ActiveRecord::Migration
  def change
    create_table :event_products do |t|
      t.string :name
      t.integer :price
      t.integer :event_id

      t.timestamps
    end
    add_index :event_products, [:event_id]
  end
end
