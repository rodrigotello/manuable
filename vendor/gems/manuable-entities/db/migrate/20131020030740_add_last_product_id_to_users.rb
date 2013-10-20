class AddLastProductIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_product_id, :integer
  end
end
