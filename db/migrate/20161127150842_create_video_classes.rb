class CreateVideoClasses < ActiveRecord::Migration
  def change
    create_table :video_classes do |t|
      t.string :title
      t.string :link
      t.string :picture
      t.belongs_to :sub_category, index: true
      t.timestamps null: false
    end
  end
end
