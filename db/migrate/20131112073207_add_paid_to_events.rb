class AddPaidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :paid, :boolean, default: false
  end
end
