class SubCategory < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :answered_questions, through: :questions

  def questions_answered user_id
    self.questions.where(id: self.answered_questions.where(user_id: user_id).pluck(:question_id))
  end

  def answered_correctly user_id
    self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: true).pluck(:question_id))
  end

  def answered_incorrectly user_id
    self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: false).pluck(:question_id))
  end
end
