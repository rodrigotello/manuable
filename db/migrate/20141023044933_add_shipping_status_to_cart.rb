class AddShippingStatusToCart < ActiveRecord::Migration
  def change
  	add_column :carts, :shipping_boolean, :boolean, default: true
  end
end
