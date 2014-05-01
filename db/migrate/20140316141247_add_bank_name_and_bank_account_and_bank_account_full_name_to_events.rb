class AddBankNameAndBankAccountAndBankAccountFullNameToEvents < ActiveRecord::Migration
  def change
    add_column :events, :bank_name, :string
    add_column :events, :bank_account, :string
    add_column :events, :bank_account_full_name, :string
    add_column :events, :bank_clabe, :string
  end
end
