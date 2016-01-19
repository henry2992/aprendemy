class RenameQuestionIdInAnsweredQuestion < ActiveRecord::Migration
  def change
    rename_column :answered_questions, :questions_id, :question_id
  end
end
