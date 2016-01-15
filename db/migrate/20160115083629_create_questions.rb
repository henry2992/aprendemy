class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :content
      t.integer :choice_id
      t.belongs_to :user
      t.belongs_to :sub_category
      t.timestamps null: false
    end
  end
end
