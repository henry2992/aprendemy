class Category < ActiveRecord::Base
  has_many :sub_categories, counter_cache: true
  has_many :questions, through: :sub_categories

  has_many :simulated_categories, inverse_of: :category
  # has_many :tutorials

  belongs_to :user
  belongs_to :course

  def answered_questions_list user_id
    Question.where('sub_category_id IN (?) AND id IN (?)', self.sub_categories.pluck(:id), AnsweredQuestion.where(user_id: user_id).pluck(:question_id))
  end

  def answered_correctly user_id
    Question.where('sub_category_id IN (?) AND id IN (?)', self.sub_categories.pluck(:id), AnsweredQuestion.where(user_id: user_id, correct: true).pluck(:question_id))
  end

  def answered_incorrectly user_id
    Question.where('sub_category_id IN (?) AND id IN (?)', self.sub_categories.pluck(:id), AnsweredQuestion.where(user_id: user_id, correct: false).pluck(:question_id))
  end

  def unanswered_questions user_id
    answered_questions_ids = "SELECT answered_questions.id FROM answered_questions INNER JOIN questions ON answered_questions.question_id = questions.id WHERE answered_questions.user_id = (?) AND questions.sub_category_id IN (?)"
    self.questions.includes(:choices).where("questions.id NOT IN (#{answered_questions_ids})", user_id, self.sub_categories.pluck(:id))
  end
end
