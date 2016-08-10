class UpdateChoiceFromAnswer < ActiveRecord::Migration
  def change
    remove_column :answers, :choice_id, :integer
    add_reference :answers, :choice, index: true, foreign_key: true, null: true
  end
end
