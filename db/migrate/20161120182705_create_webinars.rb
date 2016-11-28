class CreateWebinars < ActiveRecord::Migration
  def change
    create_table :webinars do |t|
      t.string :subject
      t.string :professor
      t.text :description
      t.datetime :time
      t.boolean :online
      t.string :link
      t.string :code

      t.timestamps null: false
    end
  end
end
