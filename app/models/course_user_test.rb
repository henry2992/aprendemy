class CourseUserTest < ActiveRecord::Base
  belongs_to :test
  belongs_to :course_user

  validates_presence_of :test, :course_user

end
