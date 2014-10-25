class AddDefaultAddressToUser < ActiveRecord::Migration
  def change
  	add_column :users, :default_shipping_address, :integer
  end
end
