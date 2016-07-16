class ChangeCompletedFromCourseUserTest < ActiveRecord::Migration
  def change
    remove_column :course_user_tests, :completed, :boolean
    add_column :course_user_tests, :status, :int
  end
end
