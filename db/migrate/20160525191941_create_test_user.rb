class CreateTestUser < ActiveRecord::Migration
  def change
    create_table :test_users do |t|
      t.belongs_to :test, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
    end
  end
end
