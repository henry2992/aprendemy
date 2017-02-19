class AddAttitudeTestObservationToUser < ActiveRecord::Migration
  def change
    add_column :users, :attitude_test_observation, :text
  end
end
