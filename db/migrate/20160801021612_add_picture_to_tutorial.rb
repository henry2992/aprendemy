class AddPictureToTutorial < ActiveRecord::Migration
  def change
    add_column :tutorials, :picture, :string
  end
end
