class CreateGeolocationTables < ActiveRecord::Migration
  def up
    create_table :cities do |t|
      t.string :name, length: 50
      t.integer :state_id
      t.decimal :longitude
      t.decimal :latitude
    end

    create_table :states do |t|
      t.string :name, length: 50
    end
    add_index :cities, :state_id
    add_index :cities, :name
    add_index :states, :name
  end

  def down
    drop_table :cities
    drop_table :states
  end
end
