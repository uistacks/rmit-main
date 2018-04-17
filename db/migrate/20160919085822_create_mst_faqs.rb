class CreateMstFaqs < ActiveRecord::Migration
  def change
    create_table :mst_faqs do |t|
    	t.string :question
    	t.string :answer
    	t.string :slug
    	t.string :status
    	t.integer :lang_id 
    	t.timestamps null: false
    end
  end
end
