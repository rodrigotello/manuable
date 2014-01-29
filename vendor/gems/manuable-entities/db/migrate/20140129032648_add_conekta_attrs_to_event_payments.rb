class AddConektaAttrsToEventPayments < ActiveRecord::Migration
  def change
    add_column :event_payments, :barcode_url, :string
  end
end
