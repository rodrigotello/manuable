class ChangeColumnTransactionidForOrderidInOrderItem < ActiveRecord::Migration
  def change
  	rename_column :order_items, :transaction_id, :order_id
  end
end
