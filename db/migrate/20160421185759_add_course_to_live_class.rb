class AddCourseToLiveClass < ActiveRecord::Migration
  def change
    add_reference :live_classes, :course, index: true, foreign_key: true
  end
end
