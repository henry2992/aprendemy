class AddMaterialToTutorial < ActiveRecord::Migration
  def change
    add_reference :tutorials, :material, polymorphic: true, index: true
  end
end
