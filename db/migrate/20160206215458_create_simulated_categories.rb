class CreateSimulatedCategories < ActiveRecord::Migration
  def change
    create_table :simulated_categories do |t|
      t.belongs_to :category

      t.timestamps null: false
    end
  end
end
