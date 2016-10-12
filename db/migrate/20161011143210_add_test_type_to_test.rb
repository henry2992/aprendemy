class AddTestTypeToTest < ActiveRecord::Migration
  def change
    add_column :tests, :test_type, :integer, :default => 0
  end
end
