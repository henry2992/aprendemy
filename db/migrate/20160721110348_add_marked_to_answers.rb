class AddMarkedToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :marked, :integer, default: 0
  end
end
