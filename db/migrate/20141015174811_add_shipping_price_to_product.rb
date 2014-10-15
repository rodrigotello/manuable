class AddShippingPriceToProduct < ActiveRecord::Migration
  def change
    add_column :products, :shipping, :integer
  end
end
