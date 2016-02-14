class AddMarkedColumnToSimulatorAnsweredQuestions < ActiveRecord::Migration
  def change
    add_column :simulator_answered_questions, :marked_status, :integer, default: 0
    remove_column :simulators, :completed
    add_column :simulators, :status, :integer, default: 0
  end
end
