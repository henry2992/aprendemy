class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :owner_id
      t.string :owner_type
      t.integer :points
      t.belongs_to :point_action
      t.integer :recipient_id
      t.string :recipient_type
      t.timestamps null: false
    end
  end
end
