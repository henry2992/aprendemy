class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :resource_progresses

  has_many :course_user_tests

  has_one :course_user_plan, :dependent => :destroy
  has_one :plan, :through => :course_user_plan
  
  validates :user, :course, presence: true

  def progress_percent
    (resource_progresses.where(completed: true).count*100)/total_resources
  end

  def total_resources
    Resource.where(section_id: course.sections.map(&:id)).count
  end
end
