class ChangeDefaultValuesInBrands < ActiveRecord::Migration
  def change
  	change_column :brands, :name, :string, default: ""
  	change_column :brands, :address1, :string, default: ""
    change_column :brands, :address2, :string, default: ""
    change_column :brands, :neighborhood, :string, default: ""
    change_column :brands, :zip, :integer, default: 0
    change_column :brands, :city, :integer, default: 0
    change_column :brands, :state, :integer, default: 0
    change_column :brands, :mobile_phone, :integer, default: 0
    change_column :brands, :local_phone, :integer, default: 0
    change_column :brands, :email, :string, default: ""
    change_column :brands, :facebook, :string, default: ""
    change_column :brands, :twitter, :string, default: ""
    change_column :brands, :instagram, :string, default: ""
    change_column :brands, :youtube, :string, default: ""
    change_column :brands, :tumblr, :string, default: ""
    change_column :brands, :pinterest, :string, default: ""
  end
end
