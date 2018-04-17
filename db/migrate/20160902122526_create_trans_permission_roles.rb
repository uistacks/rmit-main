class CreateTransPermissionRoles < ActiveRecord::Migration
  def change
    create_table :trans_permission_roles do |t|
      t.integer :permission_id
      t.integer :role_id
      
      t.timestamps null: false
    end
  end
end
