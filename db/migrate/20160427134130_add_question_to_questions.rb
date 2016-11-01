class AddQuestionToQuestions < ActiveRecord::Migration
  def change
    add_reference :questions, :question, index: true, foreign_key: true
  end
end
