class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :name
      t.string :color
      t.belongs_to :event, index: true
      t.timestamps null: false
    end
  end
end
