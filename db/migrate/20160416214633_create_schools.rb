class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
      t.string :name
      t.text :description
      t.string :image

      t.timestamps null: false
    end
  end
end
