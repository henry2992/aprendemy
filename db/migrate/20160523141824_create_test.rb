class CreateTest < ActiveRecord::Migration
  def change
    create_table :tests do |t|
      t.string :title
      t.text :description
      t.integer :time_limit
      t.integer :total_questions
    end
  end
end
