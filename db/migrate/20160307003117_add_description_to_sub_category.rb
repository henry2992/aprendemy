class AddDescriptionToSubCategory < ActiveRecord::Migration
  def change
    add_column :sub_categories, :description, :text
  end
end
