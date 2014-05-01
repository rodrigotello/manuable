class AddConektaChargeIdToEventPayments < ActiveRecord::Migration
  def change
    add_column :event_payments, :conekta_charge_id, :string
  end
end
