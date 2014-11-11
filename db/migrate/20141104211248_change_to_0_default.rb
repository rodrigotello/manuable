class ChangeTo0Default < ActiveRecord::Migration
  def change
  	 change_column :products, :shipping, :integer, default: 0
  end
end
