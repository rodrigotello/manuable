class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :total
      t.string :conekta_token
      t.integer :status

      t.timestamps
    end
  end
end
