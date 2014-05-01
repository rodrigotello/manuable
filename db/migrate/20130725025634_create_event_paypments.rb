class CreateEventPaypments < ActiveRecord::Migration
  def up
    create_table :event_payments do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :event_price
      t.integer :grand_total
      t.boolean :paid, default: false
    end

    create_table :event_product_payments do |t|
      t.integer :event_product_id
      t.integer :event_payment_id
      t.integer :event_id
      t.integer :user_id
      t.integer :units
      t.integer :unit_price
      t.integer :total
    end
  end

  def down
    drop_table :event_payments
    drop_table :event_product_payments
  end
end
