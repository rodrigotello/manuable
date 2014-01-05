class ChangeLikesCountInProducts < ActiveRecord::Migration
  def change
    change_column :products, :likes_count, :integer, default: 0
  end
end
