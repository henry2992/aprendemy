class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :text
      t.belongs_to :subcategory, index: true
      t.timestamps null: false
    end
  end
end
