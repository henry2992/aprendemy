class AddVideoToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :video_url, :string
  end
end
