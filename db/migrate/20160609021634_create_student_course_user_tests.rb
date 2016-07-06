class CreateStudentCourseUserTests < ActiveRecord::Migration
  def change
    create_table :student_course_user_tests do |t|
      t.integer :course_user_id
      t.integer :test_id

      t.timestamps null: false
    end
  end
end
