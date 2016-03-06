class CreatePointActions < ActiveRecord::Migration
  def change
    create_table :point_actions do |t|
      t.string :action
      t.string :description
      t.integer :points_alloted
      t.timestamps null: false
    end
  end
end
