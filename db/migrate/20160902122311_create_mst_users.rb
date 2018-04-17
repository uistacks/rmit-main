class CreateMstUsers < ActiveRecord::Migration
  def change
    create_table :mst_users do |t|
      t.string :user_email
      t.string :user_password
      t.string :role

      t.timestamps null: false
    end
  end
end
