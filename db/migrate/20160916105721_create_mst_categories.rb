class CreateMstCategories < ActiveRecord::Migration
  def change
    create_table :mst_categories do |t|
    	t.integer :parent_id
      t.string :slug
      t.timestamps null: false
    end
  end
end
