class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :role
      t.belongs_to :user_role
      t.timestamps null: false
    end
  end
end
