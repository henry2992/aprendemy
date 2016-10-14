class UpdateFieldsFromTest < ActiveRecord::Migration
  def change
    change_column :tests, :time_limit, :integer, :null => true
    change_column :tests, :course_id, :string, :null => true
  end
end
