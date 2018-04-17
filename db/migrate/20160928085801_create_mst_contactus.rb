class CreateMstContactus < ActiveRecord::Migration
  def change
    create_table :mst_contactus do |t|
    	t.string :fullname
    	t.string :user_email
    	t.string :subject
    	t.string :message
    	t.string :status
        t.timestamps null: false
    end
  end
end
