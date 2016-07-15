class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :generic_name
      t.references :material, polymorphic: true, index: true
      t.timestamps null: false
    end
  end
end
