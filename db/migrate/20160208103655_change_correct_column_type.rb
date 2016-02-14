class ChangeCorrectColumnType < ActiveRecord::Migration
  def change
    remove_column :simulator_answered_questions, :status
    add_column :simulator_answered_questions, :status, :integer, default: 0
  end
end
