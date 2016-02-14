class RenameUserRoleColumnInUserRoles < ActiveRecord::Migration
  def change
    rename_column :user_roles, :user_role_id,  :user_id
    change_column :user_roles, :role, :string, default: 'user'
  end
end
