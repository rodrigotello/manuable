class RemoveAttachmentFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :attachment
    remove_column :products, :materials
    remove_column :products, :on_sale
    remove_column :products, :made_by
  end

  def down
    add_column :products, :attachment, :string
  end
end
