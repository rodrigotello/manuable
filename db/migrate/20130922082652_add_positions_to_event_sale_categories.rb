class AddPositionsToEventSaleCategories < ActiveRecord::Migration
  def change
    add_column :event_sale_categories, :positions, :string
  end
end
