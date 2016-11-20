class CreateUserAttitudeTest < ActiveRecord::Migration
  def change
    create_table :user_attitude_tests do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :test, index: true, foreign_key: true
    end
  end
end
