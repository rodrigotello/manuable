class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :address
      t.integer :spaces
      t.string :cover
      t.integer :user_id
      t.integer :price
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
