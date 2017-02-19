class CreateAreaQuestion < ActiveRecord::Migration
  def change
    create_table :area_questions do |t|
      t.belongs_to :area, index: true, foreign_key: true
      t.belongs_to :question, index: true, foreign_key: true
      t.string :timestamps
    end
  end
end
