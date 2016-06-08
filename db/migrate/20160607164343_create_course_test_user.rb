class CreateCourseTestUser < ActiveRecord::Migration
  def change
    remove_column :tests, :course_user_id, :integer
    create_table :course_test_users do |t|
      t.belongs_to :test, index: true, foreign_key: true
      t.belongs_to :course_user, index: true, foreign_key: true
      t.boolean    :completed, default: false

      t.timestamps null: false
    end
  end
end
