class AddMaterialsToProduct < ActiveRecord::Migration
  def change
    add_column :products, :materials, :string
  end
end
