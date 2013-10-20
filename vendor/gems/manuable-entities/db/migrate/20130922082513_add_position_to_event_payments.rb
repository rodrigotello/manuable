class AddPositionToEventPayments < ActiveRecord::Migration
  def change
    add_column :event_payments, :position, :integer
  end
end
