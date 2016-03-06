class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :points
      t.integer :pointable_id
      t.string :pointable_type
      t.timestamps null: false
    end
  end
end
