class CreateSimulatorTypes < ActiveRecord::Migration
  def change
    create_table :simulator_types do |t|
      t.string :name
      t.integer :total_questions
      t.time :time_duration
      
      t.timestamps null: false
    end
  end
end
