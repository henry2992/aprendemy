class DropSimulatedCategoryTable < ActiveRecord::Migration
  def change
    drop_table :simulated_categories
    drop_table :simulator_types
    drop_table :simulators
    drop_table :answered_questions
    drop_table :simulator_answered_questions
  end
end
