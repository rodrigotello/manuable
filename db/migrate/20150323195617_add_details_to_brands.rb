class AddDetailsToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :address1, :string
    add_column :brands, :address2, :string
    add_column :brands, :neighborhood, :string
    add_column :brands, :zip, :integer
    add_column :brands, :city, :integer
    add_column :brands, :state, :integer
    add_column :brands, :mobile_phone, :integer
    add_column :brands, :local_phone, :integer
    add_column :brands, :email, :string
    add_column :brands, :facebook, :string
    add_column :brands, :twitter, :string
    add_column :brands, :instagram, :string
    add_column :brands, :youtube, :string
    add_column :brands, :tumblr, :string
    add_column :brands, :pinterest, :string
  end
end
