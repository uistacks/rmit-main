class CreateTransPermissionUsers < ActiveRecord::Migration
  def change
    create_table :trans_permission_users do |t|
      t.integer :user_id
      t.integer :permission_id
      
      t.timestamps null: false
    end
  end
end
