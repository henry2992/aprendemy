class SubCategory < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :answered_questions, through: :questions

  answered = "self.questions.where(id: self.answered_questions.where(user_id: user_id).pluck(:question_id))"
  correct = "self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: true).pluck(:question_id))"
  incorrect = "self.questions.where(id: self.answered_questions.where(user_id: user_id, correct: false).pluck(:question_id))"
  unanswered = "self.questions.includes(:choices).where('id NOT IN (?)', (answered_question_ids unless answered_question_ids.empty?) || 0)"

  {questions_list: answered, correctly: correct, incorrectly: incorrect, not: unanswered}.each do |action, value|
    define_method("answered_#{action}") do |user_id|
      eval value
    end
  end

end




  # def unanswered_questions *args
  #   user_id = args[0][:user_id]
  #   answered_question_ids = self.answered_questions.where(user_id: user_id).pluck(:question_id)
  #   answered_not(args)
  # end
