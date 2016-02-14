class AddTimeToLiveClasses < ActiveRecord::Migration
  def change
    add_column :live_classes, :time, :datetime
  end
end
