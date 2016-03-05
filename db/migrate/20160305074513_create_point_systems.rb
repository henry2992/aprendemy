class CreatePointSystems < ActiveRecord::Migration
  def change
    create_table :point_systems do |t|
      t.string :action
      t.integer :points_alloted
      t.timestamps null: false
    end
  end
end
