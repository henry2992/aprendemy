class RemoveTotalQuestionsFromTest < ActiveRecord::Migration
  def change
    remove_column :tests, :total_questions, :integer
  end
end
