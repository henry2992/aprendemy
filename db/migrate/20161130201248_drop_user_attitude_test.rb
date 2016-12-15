class DropUserAttitudeTest < ActiveRecord::Migration
  def change
    drop_table :user_attitude_tests do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :test, index: true, foreign_key: true
    end

    create_table :user_attitude_tests do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :test, index: true, foreign_key: true
      
      t.integer :status, default: 0

      t.timestamps null: false
    end

  end
end
