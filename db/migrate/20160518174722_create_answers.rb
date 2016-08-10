class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :question, index: true, foreign_key: true, null: false
      t.belongs_to :choice, index: true, foreign_key: true, null: false
      t.references :item, polymorphic: true, index: true, null: true
    end
  end
end
