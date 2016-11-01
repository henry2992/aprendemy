class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name
      t.string :province
      t.string :city
      t.string :website
      t.integer :type
      t.string :logo

      t.timestamps null: false
    end
  end
end
