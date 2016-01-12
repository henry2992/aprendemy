class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :question
      t.belongs_to :subcategory, index:true

      t.timestamps null: false
    end
  end
end
