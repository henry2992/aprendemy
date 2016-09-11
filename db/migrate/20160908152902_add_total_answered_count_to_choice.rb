class AddTotalAnsweredCountToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :total_answered_count, :integer, default: 0
    add_column :choices, :wrong_answered_count, :integer, default: 0
  end
end
