class CreateTestProgress < ActiveRecord::Migration
  def change
    create_table :test_progresses do |t|
      t.belongs_to :test_user, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true
      t.belongs_to :answer, index: true, foreign_key: true
      t.boolean    :completed, default: false
    end
  end
end
