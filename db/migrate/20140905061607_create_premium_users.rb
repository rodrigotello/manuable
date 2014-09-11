class CreatePremiumUsers < ActiveRecord::Migration
  def change
    create_table :premium_users do |t|
      t.integer :premium_user

      t.timestamps
    end
  end
end
