class RemoveSimulatorIdFromQandA < ActiveRecord::Migration
  def change
    rename_column :simulator_question_and_answers, :choice_id_id, :choice_id
    rename_column :simulators, :user_id_id, :user_id
    remove_column :simulators, :simulation_type, :string
    add_column :simulators, :simulator_type_id, :integer
    change_column :simulators, :completed, :boolean, default: false
  end
end
