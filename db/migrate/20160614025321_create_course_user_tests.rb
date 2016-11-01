class CreateCourseUserTests < ActiveRecord::Migration
  def change
    create_table :course_user_tests do |t|
      t.integer :course_user_id
      t.integer :test_id
      t.boolean :completed, default: false

      t.timestamps null: false
    end
  end
end
