class CourseUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  has_many :resource_progresses
  validates :user, :course, presence: true

  def progress_percent
    total = 0
    course.sections.each{|s| total = total + s.resources.count }
    (resource_progresses.count*100)/total
  end
end
