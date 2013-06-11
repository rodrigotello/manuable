class AddProductIdToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :product_id, :integer
  end
end
