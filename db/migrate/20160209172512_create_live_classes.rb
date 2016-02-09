class CreateLiveClasses < ActiveRecord::Migration
  def change
    create_table :live_classes do |t|
      t.string :subject
      t.string :professor
      t.string :url
      t.boolean :online_now

      t.timestamps null: false
    end
  end
end
