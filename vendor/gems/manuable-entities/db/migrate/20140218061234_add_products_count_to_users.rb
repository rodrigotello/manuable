class AddProductsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :products_count, :integer
    User.find_each {|x| User.reset_counters x.id, :products }
  end
end
