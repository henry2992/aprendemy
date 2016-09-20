class AddPositionToResource < ActiveRecord::Migration
  def change
    add_column :resources, :position, :integer, :default => 0
  end
end
