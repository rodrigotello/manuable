class ChangeIntegerToStringInPremiumUserData < ActiveRecord::Migration
  def change
  	add_column :premium_user_data, :bank_account, :string
  end
end
