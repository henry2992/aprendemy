class UserAttitudeTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :test

  has_many :answers, :through => :test

  after_destroy :delete_answers

  enum status: [:opened, :completed]

  validates_presence_of :user, :test

  def total_answers
    self.test.answers.where.not(choice_id: nil).count
  end

  def delete_answers
    self.test.answers.destroy_all
  end
end
