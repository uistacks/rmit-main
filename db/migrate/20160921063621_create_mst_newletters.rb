class CreateMstNewletters < ActiveRecord::Migration
  def change
    create_table :mst_newletters do |t|
    	t.string :newsletter_subject
    	t.string :newsletter_content
    	t.integer :lang_id
    	t.string :status
      	t.timestamps null: false
    end
  end
end
