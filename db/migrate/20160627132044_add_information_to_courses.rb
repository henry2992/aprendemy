class AddInformationToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :author, :string
    add_column :courses, :picture, :string
  end
end
