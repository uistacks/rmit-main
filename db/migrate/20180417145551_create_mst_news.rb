class CreateMstNews < ActiveRecord::Migration[5.0]
  def change
    create_table :mst_news do |t|
      t.integer :user_id
      t.string :title
      t.string :slug
      t.longtext :description
      t.longtext :url
      t.string :active

      t.timestamps
    end
  end
end
