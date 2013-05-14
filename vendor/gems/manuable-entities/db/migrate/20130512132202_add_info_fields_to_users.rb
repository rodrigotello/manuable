class AddInfoFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :about, :text
    add_column :users, :address, :string # street & number
    add_column :users, :zipcode, :integer
    add_column :users, :city_id, :integer
    add_column :users, :state_id, :integer
    add_column :users, :country_id, :integer

    add_column :users, :geolocation, :string

  end
end
