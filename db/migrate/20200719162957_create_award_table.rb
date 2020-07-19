class CreateAwardTable < ActiveRecord::Migration[6.0]
  def change
    create_table :awards do |t|
      t.string :event
      t.integer :team_id
      t.integer :player_id
      t.integer :points
      t.timestamps
    end

    remove_column :teams, :points, :integer
  end
end
