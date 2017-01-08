class AddValueCountToChoice < ActiveRecord::Migration
  def change
    add_column :choices, :value_count, :integer, default: 0
  end
end
