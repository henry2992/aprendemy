class AddExplanationToLiveClasses < ActiveRecord::Migration
  def change
    add_column :live_classes, :explanation, :text
  end
end
