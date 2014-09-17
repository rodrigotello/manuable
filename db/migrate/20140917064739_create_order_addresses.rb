class CreateOrderAddresses < ActiveRecord::Migration
  def change
    create_table :order_addresses do |t|
      t.integer :user_id
      t.string :street
      t.string :in_between_street
      t.integer :number
      t.integer :inner_number
      t.string :neighborhood
      t.integer :zip
      t.string :reference

      t.timestamps
    end
  end
end
