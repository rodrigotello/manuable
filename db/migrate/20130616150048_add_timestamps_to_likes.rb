class AddTimestampsToLikes < ActiveRecord::Migration
  def change
    add_column :likes, :created_at, :datetime
    add_column :likes, :updated_at, :datetime
  end
end
