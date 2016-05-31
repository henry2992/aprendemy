class RemoveTaskFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :answered_questions_count, :integer
    add_column :questions, :total_answered_count, :integer, null: false, default: 0
    add_column :questions, :wrong_answered_count, :integer, null: false, default: 0
  end
end
