class AddOccupationAndBirthdayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :occupation, :string
    add_column :users, :birthday, :date
  end
end
