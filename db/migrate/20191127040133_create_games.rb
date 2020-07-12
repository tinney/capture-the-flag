class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string :name, null: false
      t.boolean :active
      t.timestamps
    end

    create_table :teams do |t|
      t.string :name, null: false
      t.timestamps
    end

    create_table :players do |t|
      t.integer :team_id
      t.string :name
      t.integer :water_stat, null: false
      t.integer :food_stat, null: false
      t.integer :stamina_stat, null: false
      t.integer :strength_stat, null: false
      t.boolean :active, null: false, default: true
      t.integer :days_active, null: false, default: 0
      t.integer :days_without_water, null: false, default: 0
      t.integer :days_without_food, null: false, default: 0
      t.integer :water_count, null: false
      t.integer :food_count, null: false
      t.integer :x_location, null: false
      t.integer :y_location, null: false
      t.timestamps
    end

    create_table :moves do |t|
      t.integer :player_id
      t.integer :x_location
      t.integer :y_location
      t.timestamps
    end
  end
end
