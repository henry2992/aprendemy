class CreateLicenses < ActiveRecord::Migration
  def change
    create_table :licenses do |t|
      t.belongs_to :user
      t.integer :plan, default: 10
      t.integer :days_left, default: 10
      t.timestamps null: false
    end
  end
end
