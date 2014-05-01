class AddLikesCountToProducts < ActiveRecord::Migration
  def change
    add_column :products, :likes_count, :integer
    Product.find_each do |p|
      Product.reset_counters p.id, :likes
    end

  end
end
