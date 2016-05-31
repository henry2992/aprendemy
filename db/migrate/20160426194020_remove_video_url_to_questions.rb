class RemoveVideoUrlToQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :video_url
  end
end
