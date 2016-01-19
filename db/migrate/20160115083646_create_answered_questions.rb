class CreateAnsweredQuestions < ActiveRecord::Migration
  def change
    create_table :answered_questions do |t|
      t.boolean :correct, default: false
      t.belongs_to :user
      t.belongs_to :questions
      t.belongs_to :choice
      t.timestamps null: false
    end
  end
end
