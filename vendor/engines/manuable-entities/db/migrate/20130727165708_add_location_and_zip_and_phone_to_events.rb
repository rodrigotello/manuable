class AddLocationAndZipAndPhoneToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string
    add_column :events, :zip, :string
    add_column :events, :phone, :string
  end
end
