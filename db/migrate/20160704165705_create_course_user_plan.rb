class CreateCourseUserPlan < ActiveRecord::Migration
  def change
    create_table :course_user_plans do |t|
      t.references :course_user, index: true, foreign_key: true
      t.references :plan, index: true, foreign_key: true
      t.date :expiration_date
      t.integer :status
      
      t.timestamps null: false
    end
  end
end
