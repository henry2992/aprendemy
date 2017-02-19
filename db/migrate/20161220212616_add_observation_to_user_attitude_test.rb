class AddObservationToUserAttitudeTest < ActiveRecord::Migration
  def change
    add_column :user_attitude_tests, :observation, :text
  end
end
