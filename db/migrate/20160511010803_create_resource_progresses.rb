class CreateResourceProgresses < ActiveRecord::Migration
  def change
    create_table :resource_progresses do |t|
      t.integer :course_user_id
      t.integer :section_id
      t.integer :resource_id
      t.boolean :completed, :default => false

      t.timestamps null: false
    end
  end
end
