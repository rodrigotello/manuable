class RemoveMaterials < ActiveRecord::Migration
  def up
  	drop_table :materials
  end

  def down
  	create_table :materials
  end
end
