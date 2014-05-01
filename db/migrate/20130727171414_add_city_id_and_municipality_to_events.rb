class AddCityIdAndMunicipalityToEvents < ActiveRecord::Migration
  def change
    add_column :events, :city_id, :integer
    add_column :events, :municipality, :string
  end
end
