class Simulator < ActiveRecord::Base
  # serialize :question_ids, Array
  belongs_to :user
  has_many :simulator_answered_questions
  has_many :questions, through: :simulator_answered_questions
  
  def questions_answered
    Question.where('id in (?)', self.simulator_answered_questions.where.not(choice_id: nil).pluck(:question_id))
  end
end
