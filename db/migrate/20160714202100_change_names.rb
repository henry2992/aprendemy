class ChangeNames < ActiveRecord::Migration


   def change
    rename_column :resources, :generic_name, :name
  end
end
