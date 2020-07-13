class DropResources < ActiveRecord::Migration[6.0]
  def change
    drop_table :resources
  end
end
