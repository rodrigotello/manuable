class AddLocationMapToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location_map, :string
  end
end
