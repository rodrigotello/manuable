class AmountPaidToEventPayments < ActiveRecord::Migration
  def up
    add_column :event_payments, :amount_paid, :integer
  end

  def down
    remove_column :event_payments, :amount_paid
  end
end
