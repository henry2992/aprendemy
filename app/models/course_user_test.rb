class CourseUserTest < ActiveRecord::Base
  belongs_to :test
  belongs_to :course_user

  has_many :answers, :as => :item, dependent: :destroy

  validates_presence_of :test, :course_user
  validates_uniqueness_of :test_id, :scope => :course_user_id

  def correct_answers
    self.answers.all.where(choice_id: Question.where(id: self.answers.map(&:question_id)).map(&:choice_id)).count
  end
  
  def incorrect_answers
    self.answers.all.count - self.correct_answers
  end
end
