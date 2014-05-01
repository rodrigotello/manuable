class AddProductsCountToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :products_count, :integer
    Category.find_each(select: 'id') do |result|
      Category.reset_counters(result.id, :products)
    end
  end
end
