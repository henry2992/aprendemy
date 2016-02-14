class RenameQandATable < ActiveRecord::Migration
  def change
    rename_table :simulator_question_and_answers, :simulator_answered_questions
    rename_column :simulator_answered_questions, :correct, :status
    change_column :simulator_answered_questions, :status, :string, default: '0'
  end
end
