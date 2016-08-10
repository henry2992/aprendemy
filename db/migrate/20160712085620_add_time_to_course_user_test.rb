class AddTimeToCourseUserTest < ActiveRecord::Migration
  def change
    add_column :course_user_tests, :time_left, :time, default: '00:00:00'
    add_column :course_user_tests, :last_started, :datetime, default: DateTime.now
    add_column :course_user_tests, :last_paused, :datetime
    add_column :course_user_tests, :time_completed, :datetime
  end
end
