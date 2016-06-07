class CreateTestCourseUser < ActiveRecord::Migration
  def change
    remove_column :tests, :course_user_id, :integer
    create_table :test_course_users do |t|
      t.belongs_to :test, index: true, foreign_key: true
      t.belongs_to :course_user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
