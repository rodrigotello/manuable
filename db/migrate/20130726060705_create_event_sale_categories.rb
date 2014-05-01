class CreateEventSaleCategories < ActiveRecord::Migration
  def up
    create_table :event_sale_categories do |t|
      t.integer :event_id
      t.string :name
      t.integer :price
    end
    add_column :event_payments, :event_sale_category_id, :integer
  end

  def down
    drop_table :event_sale_categories
  end
end
