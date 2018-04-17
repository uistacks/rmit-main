class CreateTransRoleUsers < ActiveRecord::Migration
  def change
    create_table :trans_role_users do |t|
      t.integer :user_id
      t.integer :role_id

      t.timestamps null: false
    end
  end
end
