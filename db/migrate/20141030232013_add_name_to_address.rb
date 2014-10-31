class AddNameToAddress < ActiveRecord::Migration
  def change
  	add_column :order_addresses, :address_title, :string
  	add_column :order_addresses, :city, :integer
  	add_column :order_addresses, :state, :integer
  end
end
