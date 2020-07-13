class UpdateFlagInformation < ActiveRecord::Migration[6.0]
  def change
    add_column :teams, :flag_x_location, :integer
    add_column :teams, :flag_y_location, :integer
    add_column :teams, :flag_holder_id,  :integer
  end
end
