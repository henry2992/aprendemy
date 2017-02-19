class AddAreaToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :area, :integer, default: 0
  end
end
