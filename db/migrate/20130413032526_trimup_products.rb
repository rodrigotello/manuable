class TrimupProducts < ActiveRecord::Migration
  def up
    add_column :products, :category_id, :integer
    add_column :products, :on_sale, :boolean
    remove_column :products, :weight
    remove_column :products, :height
    remove_column :products, :width
    remove_column :products, :depth
    remove_column :products, :available_items
    remove_column :products, :available_at
    remove_column :products, :on_demand, default: false
    remove_column :products, :factoring_time
    remove_column :products, :delivery_method
    remove_column :products, :how_is_done
    remove_column :products, :what_it_is
    remove_column :products, :usage
    remove_column :products, :materials
  end

  def down
    remove_column :products, :category_id
    remove_column :products, :on_sale, :boolean
    add_column :products, :weight, :integer
    add_column :products, :height, :integer
    add_column :products, :width, :integer
    add_column :products, :depth, :integer
    add_column :products, :available_items, :integer
    add_column :products, :available_at, :datetime
    add_column :products, :on_demand, :boolean, default: false
    add_column :products, :factoring_time, :integer
    add_column :products, :delivery_method, :string
    add_column :products, :how_is_done, :text
    add_column :products, :what_it_is, :text
    add_column :products, :usage, :text
    add_column :products, :materials, :text
  end
end
