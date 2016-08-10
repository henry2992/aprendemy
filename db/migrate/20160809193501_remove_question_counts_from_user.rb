class RemoveQuestionCountsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :questions_count, :integer
  end
end
