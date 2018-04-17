class CreateTransUserInformations < ActiveRecord::Migration
  def change
    create_table :trans_user_informations do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :user_name
      t.string :user_mobile
      t.string :user_birth_date
      t.string :user_address
      t.string :user_zipcode
      t.string :profile_picture
      t.string :cover_picture
      t.string :about_me
      t.string :gender
      t.string :user_type
      t.string :user_status
      t.string :activation_code
      t.string :company_name
      t.string :designation
      t.string :provider
      t.string :provider_id
      t.string :promo_code

      t.timestamps null: false
    end
  end
end
