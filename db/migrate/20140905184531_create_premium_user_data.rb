class CreatePremiumUserData < ActiveRecord::Migration
  def change
    create_table :premium_user_data do |t|
      t.string :account_owner
      t.integer :bank_account
      t.string :clabe
      t.string :rfc
      t.string :bank_name

      t.timestamps
    end
  end
end
