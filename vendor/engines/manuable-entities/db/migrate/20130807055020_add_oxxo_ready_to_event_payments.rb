class AddOxxoReadyToEventPayments < ActiveRecord::Migration
  def change
    add_column :event_payments, :oxxo_ready, :boolean, default: false
  end
end
