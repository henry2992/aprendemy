class AddCounterCacheToSubCategory < ActiveRecord::Migration
  def change
    add_column :questions, :answered_questions_count, :integer, default: 0
  end
end
