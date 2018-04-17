class CreateTransCategories < ActiveRecord::Migration
  def change
    create_table :trans_categories do |t|
    	t.string :category_name
			t.string :category_name_ch
    	t.string :description
    	t.string :category_icon
    	t.integer :lang_id
    	t.integer :category_id_fk
      	t.timestamps null: false
    end
  end
end
