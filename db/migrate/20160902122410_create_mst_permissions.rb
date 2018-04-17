class CreateMstPermissions < ActiveRecord::Migration
  def change
    create_table :mst_permissions do |t|
      t.string :name
      
      t.timestamps null: false
    end
  end
end
