class AddLatAndLngToEvents < ActiveRecord::Migration
  def change
    add_column :events, :lat, :decimal
    add_column :events, :lng, :decimal
  end
end
