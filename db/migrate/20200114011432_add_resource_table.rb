class AddResourceTable < ActiveRecord::Migration[6.0]
  def change
    create_table :resources do |t|
      t.integer :x_location, null: false, default: 0
      t.integer :y_location, null: false, default: 0
      t.integer :amount, null: false, default: 1
      t.boolean :active, null: false, default: true
      t.boolean :is_water, null: false, default: false
      t.boolean :is_food, null: false, default: false
      t.timestamps
    end
  end
end
