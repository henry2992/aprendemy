class AddLegendToTest < ActiveRecord::Migration
  def change
    add_column :tests, :legend, :text, default: ""
  end
end
