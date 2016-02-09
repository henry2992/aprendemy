class AddMetaToSimulatorTypes < ActiveRecord::Migration
  def change
    add_column :simulator_types, :description, :string
    add_column :simulator_types, :limit, :integer
    add_column :simulator_types, :points, :integer
    add_column :users, :role, :integer, default: 0
    drop_table :user_roles
  end
end
