class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :text
      t.boolean :correct
      t.belongs_to :question, index: true

      t.timestamps null: false
    end
  end
end
