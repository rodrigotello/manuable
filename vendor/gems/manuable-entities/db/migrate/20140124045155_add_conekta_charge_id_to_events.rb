class AddConektaChargeIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :conekta_charge_id, :string
  end
end
