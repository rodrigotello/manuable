class AddOxxoAttributesToEventPayments < ActiveRecord::Migration
  def change
    add_column :event_payments, :oxxo_expires_on, :date
    add_column :event_payments, :oxxo_barcode, :string
  end
end
