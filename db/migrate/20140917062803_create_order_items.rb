class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :transaction_id
      t.integer :product_id

      t.timestamps
    end
  end
end
