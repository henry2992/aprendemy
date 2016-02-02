class AddUrlToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :url, :string
  end
end
