class CreateMstContentPages < ActiveRecord::Migration
  def change
    create_table :mst_content_pages do |t|
      t.string :title
      t.string :slug
      t.string :content
      t.string :meta_keyword
      t.string :meta_description
      t.string :active
      t.string :lang_id

      t.timestamps null: false
    end
  end
end
