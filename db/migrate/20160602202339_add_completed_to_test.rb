class AddCompletedToTest < ActiveRecord::Migration
  def change
    add_column :tests, :completed, :boolean, default: false
  end
end
