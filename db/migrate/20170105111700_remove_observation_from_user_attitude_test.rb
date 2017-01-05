class RemoveObservationFromUserAttitudeTest < ActiveRecord::Migration
  def change
    remove_column :user_attitude_tests, :observation, :text
  end
end
