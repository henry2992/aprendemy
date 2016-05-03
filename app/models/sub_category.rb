class SubCategory < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :answered_questions, through: :questions

  answered = "self.questions.where(id: self.answered_questions.where(user_id: user_id).pluck(:question_id))"
  correct = "self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: true).pluck(:question_id))"
  incorrect = "self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: false).pluck(:question_id))"
  unanswered = ""

  def unanswered_questions user_id
    answered_questions_ids = self.answered_questions.where(user_id: user_id).pluck(:question_id)
    self.questions.includes(:choices).where('id NOT IN (?)', (answered_questions_ids unless answered_questions_ids.empty?) || 0)
  end

  {questions_list: answered, correctly: correct, incorrectly: incorrect, not: unanswered}.each do |action, value|
    define_method("answered_#{action}") do #|user_id|
      eval value
    end
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'SubCategory').sum(:points)
  end
end
