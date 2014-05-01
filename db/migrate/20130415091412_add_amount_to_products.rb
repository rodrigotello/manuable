class AddAmountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :amount, :string
  end
end
