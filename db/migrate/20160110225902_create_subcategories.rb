class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :title
      

      t.timestamps null: false
      t.belongs_to :category, index: true
    end
  end
end
