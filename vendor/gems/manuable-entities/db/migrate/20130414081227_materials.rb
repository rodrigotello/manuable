class Materials < ActiveRecord::Migration
  def up
  	create_table :materials, :id => false do |t|
  		t.integer :category_id
  		t.integer :product_id
  	end
  end

  def down
  	drop_table :materials
  end
end