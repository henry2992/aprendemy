class AddCourseUserToTest < ActiveRecord::Migration
  def change
    add_reference :tests, :course_user, index: true, foreign_key: true
  end
end
