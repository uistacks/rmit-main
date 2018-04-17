class CreateTransNewsletterSubscriptions < ActiveRecord::Migration
  def change
    create_table :trans_newsletter_subscriptions do |t|
    	t.string :user_email
    	t.string :status
    	t.string :user_subscription_code
    	t.integer :is_subscribe_for_daily
      	t.timestamps null: false
    end
  end
end
