class AddParentToQuestion < ActiveRecord::Migration
  def change
    add_reference :questions, :parent, polymorphic: true, index: true
    remove_column :questions, :task_id, :integer
  end
end
