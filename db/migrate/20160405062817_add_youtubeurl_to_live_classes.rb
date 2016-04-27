class AddYoutubeurlToLiveClasses < ActiveRecord::Migration
  def change
    add_column :live_classes, :Urlyoutube, :string
  end
end
