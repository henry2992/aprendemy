class Simulator < ActiveRecord::Base
  # serialize :question_ids, Array
  belongs_to :user, dependent: :destroy
  has_many :simulator_answered_questions
  has_many :questions, through: :simulator_answered_questions
  belongs_to :simulator_type, dependent: :destroy
  enum status: [:paused, :completed]

  def questions_answered
    Question.where('id in (?)', self.simulator_answered_questions.where.not(status: 'unanswered').pluck(:question_id))
  end

  def answered_correctly
    self.questions.where(id: self.simulator_answered_questions.correct.pluck(:question_id))
  end

  def answered_incorrectly
    self.questions.where(id: self.simulator_answered_questions.wrong.pluck(:question_id))
  end

  def unanswered_questions
    Question.where('id in (?)', self.simulator_answered_questions.unanswered.pluck(:question_id))
  end
end
