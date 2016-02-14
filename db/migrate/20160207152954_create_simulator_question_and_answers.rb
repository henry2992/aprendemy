class CreateSimulatorQuestionAndAnswers < ActiveRecord::Migration
  def change
    create_table :simulator_question_and_answers do |t|
      t.boolean :correct, default: false
      t.belongs_to :simulator
      t.belongs_to :question
      t.belongs_to :user
      t.belongs_to :choice_id
      t.timestamps null: false
    end
  end
end
