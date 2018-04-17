class CreateMstSettings < ActiveRecord::Migration
  def change
    create_table :mst_settings do |t|
      t.string :key
      t.string :name
      t.string :description
      t.string :value
      t.string :field
      t.string :active
      t.string :lang_id

      t.timestamps null: false
    end
  end
end
