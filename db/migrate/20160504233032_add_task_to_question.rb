class AddTaskToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :task, index: true, foreign_key: true
  end
end
