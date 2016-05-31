class RemoveWebsiteFromCareer < ActiveRecord::Migration
  def change
  	remove_column :careers, :website
  end
end
