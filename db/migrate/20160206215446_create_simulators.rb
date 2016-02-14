class CreateSimulators < ActiveRecord::Migration
  def change
    create_table :simulators do |t|
      t.belongs_to :user_id
      t.boolean :completed, default: true
      t.time :time_left, default: '00:00:30'
      t.string :simulation_type, default: 'mini'
      t.datetime :last_started, default: DateTime.now
      t.datetime :last_paused
      t.datetime :time_completed

      t.timestamps null: false
    end
  end
end
