class CreatePlan < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name
      t.text :description
      t.integer :expiration_days
      t.integer :licence_type
      t.decimal :price, :precision => 2

      t.timestamps null: false
    end
  end
end
