class AddOwnerToPremiumUserData < ActiveRecord::Migration
  def change
    add_column :premium_user_data, :user_id, :integer
  end
end
