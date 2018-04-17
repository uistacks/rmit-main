class CreateMstEmailTemplates < ActiveRecord::Migration
  def change
    create_table :mst_email_templates do |t|
      t.string :email_template_title
      t.string :email_template_subject
      t.string :email_template_content
      t.integer :lang_id
      t.string :active
     
      t.timestamps null: false
    end
  end
end
