class CreateTransBlogPosts < ActiveRecord::Migration
  def change
    create_table :trans_blog_posts do |t|
    	t.string :post_title
    	t.string :seo_url
    	t.integer :category_id
    	t.string :post_short_description
    	t.string :post_content
    	t.string :page_title
    	t.string :post_tags
	    t.string :post_keyword
	    t.string :posted_by
	    t.integer :lang_id
        t.string :status
        t.string :blog_image

        t.timestamps null: false
    end
  end
end
