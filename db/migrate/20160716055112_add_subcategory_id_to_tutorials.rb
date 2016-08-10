class AddSubcategoryIdToTutorials < ActiveRecord::Migration
  def change
    add_column :tutorials, :sub_category_id, :integer
  end
end
