class UpdateTimeLeftFromCourseUserTest < ActiveRecord::Migration
  def change
    remove_column :course_user_tests, :time_left, :time
    add_column :course_user_tests, :time_left, :bigint
  end
end
