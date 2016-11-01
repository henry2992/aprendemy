class RemoveUserFromCategory < ActiveRecord::Migration
  def change
    remove_column :categories, :user_id, :integer
    remove_column :sub_categories, :user_id, :integer
  end
end
