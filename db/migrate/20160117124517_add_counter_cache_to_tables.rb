class AddCounterCacheToTables < ActiveRecord::Migration
  def change
    add_column :users, :questions_count, :integer, default: 0
    add_column :categories, :sub_categories_count, :integer, default: 0
    add_column :sub_categories, :questions_count, :integer, default: 0
  end
end
