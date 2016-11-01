class AddPictureToSubcategories < ActiveRecord::Migration
  def change
    add_column :sub_categories, :picture, :string
  end
end
