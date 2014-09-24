class AddingOxxoColumnsToOrderModel < ActiveRecord::Migration
  def change
  	add_column :orders, :oxxo_ready, :boolean
    add_column :orders, :oxxo_expires_on, :date
    add_column :orders, :oxxo_barcode, :string
    add_column :orders, :conekta_charge_id, :string
    add_column :orders, :barcode_url, :string
  end
end