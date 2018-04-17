class CreateMstBlogCategories < ActiveRecord::Migration
  def change
    create_table :mst_blog_categories do |t|
    	t.string :category_name
    	t.string :category_name_ch
    	t.string :status
      	t.timestamps null: false
    end
  end
end
