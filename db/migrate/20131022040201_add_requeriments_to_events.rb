class AddRequerimentsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :requirements, :text
  end
end
