class CreateCareers < ActiveRecord::Migration
  def change
    create_table :careers do |t|
      t.string :name
      t.text :description
      t.string :image
      t.string :website
      t.integer :type
      t.string :faculty
      t.belongs_to :school
      t.belongs_to :university

      t.timestamps null: false
    end
  end
end
