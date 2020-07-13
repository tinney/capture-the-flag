class AddPegToPlayer < ActiveRecord::Migration[6.0]
  def change
    change_table(:players) do |t|
      t.boolean :has_peg, default: false

      t.remove :water_stat
      t.remove :food_stat
      t.remove :stamina_stat
      t.remove :strength_stat
      t.remove :days_active
      t.remove :days_without_water
      t.remove :days_without_food
      t.remove :water_count
      t.remove :food_count
    end
  end
end
