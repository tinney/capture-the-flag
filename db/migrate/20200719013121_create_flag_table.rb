class CreateFlagTable < ActiveRecord::Migration[6.0]
  def change
    create_table :flags do |t|
      t.boolean :captured, default: false
      t.boolean :revealed, default: false
      t.integer :player_id
      t.integer :team_id
      t.integer :x_location
      t.integer :y_location
    end

    remove_column :teams, :flag_x_location, :integer
    remove_column :teams, :flag_y_location, :integer
    remove_column :teams, :flag_holder_id, :integer
    remove_column :teams, :flag_found, :boolean
  end
end
