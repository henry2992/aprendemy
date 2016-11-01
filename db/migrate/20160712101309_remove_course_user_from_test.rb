class RemoveCourseUserFromTest < ActiveRecord::Migration
  def change
    remove_column :tests, :course_user_id, :integer
  end
end
