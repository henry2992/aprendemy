class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :resource_progresses

  has_many :course_test_users
  
  validates :user, :course, presence: true

  def progress_percent
    (resource_progresses.where(completed: true).count*100)/total_resources
  end

  def total_resources
    Resource.where(section_id: course.sections.map(&:id)).count
  end
end
