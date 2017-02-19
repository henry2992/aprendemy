class CreateArea < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.text :description
      t.string :timestamps
    end
  end
end
