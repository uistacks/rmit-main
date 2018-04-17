class CreateTransNewsletterSends < ActiveRecord::Migration
  def change
    create_table :trans_newsletter_sends do |t|
    	t.string :user_email
    	t.integer :user_id
    	t.integer :newsletter_id
       	t.timestamps null: false
    end
  end
end
