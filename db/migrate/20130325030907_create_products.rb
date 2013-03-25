class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :user_id, nil: false
      t.integer :weight
      t.integer :height
      t.integer :width
      t.integer :depth
      t.integer :price
      t.integer :available_items
      t.datetime :available_at
      t.boolean :on_demand, default: false
      t.integer :factoring_time
      t.string :made_by
      t.string :delivery_method
      t.text :how_is_done
      t.text :what_it_is
      t.text :usage
      t.text :about
      t.text :materials

      t.timestamps
    end
  end
end
