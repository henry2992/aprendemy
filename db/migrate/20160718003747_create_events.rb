class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.belongs_to :event_type, index: true
      t.timestamps null: false
    end
  end
end
