class CreateTransBlogComments < ActiveRecord::Migration
  def change
    create_table :trans_blog_comments do |t|
    	t.integer :post_id
        t.string :commented_by
        t.integer :commented_user_id
        t.string :comment
        t.string :status
        t.timestamps null: false
    end
  end
end
