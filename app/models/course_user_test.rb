class CourseUserTest < ActiveRecord::Base
  belongs_to :test
  belongs_to :course_user

  has_many :answers, :as => :item, dependent: :destroy

  validates_presence_of :test, :course_user
  validates_uniqueness_of :test_id, :scope => :course_user_id
  # before_create :set_time
  before_update :set_time_left

  def correct_answers
    self.answers.all.where(choice_id: Question.where(id: self.answers.map(&:question_id)).map(&:choice_id)).count
  end
  
  def hour_left
    (Time.at(self.time_left) - 72000).strftime("%H")
  end

  def min_left
    (Time.at(self.time_left) - 72000).strftime("%M")
  end

  def sec_left
    (Time.at(self.time_left) - 72000).strftime("%S")
  end

  def incorrect_answers
    self.answers.all.count - self.correct_answers
  end

  def total_answers
    self.answers.where.not(choice_id: nil).count
  end

  def set_time_left
    self.last_paused = DateTime.now
    # raise self.last_started.to_yaml
    self.time_left -= self.last_paused - self.last_started
  end

  def set_time
    self.last_paused = DateTime.now
    self.time_left = (self.test.time_limit * 60) - ( self.last_paused - self.last_started )
  end
end
