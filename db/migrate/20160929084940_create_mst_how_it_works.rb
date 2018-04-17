class CreateMstHowItWorks < ActiveRecord::Migration
  def change
    create_table :mst_how_it_works do |t|
      t.string :slug
    	t.string :description
    	t.string :icon
    	t.integer :lang_id
    	t.string :status
      	t.timestamps null: false
    end
  end
end
