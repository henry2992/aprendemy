class AddPictuteToTest < ActiveRecord::Migration
  def change
    add_column :tests, :picture, :string
  end
end
