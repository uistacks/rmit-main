# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180417145551) do

  create_table "mst_blog_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category_name"
    t.string   "category_name_ch"
    t.string   "status"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "mst_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "parent_id"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_contactus", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "fullname"
    t.string   "user_email"
    t.string   "subject"
    t.string   "message"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_content_pages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "title"
    t.string   "slug"
    t.string   "content"
    t.string   "meta_keyword"
    t.string   "meta_description"
    t.string   "active"
    t.string   "lang_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "mst_email_templates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "email_template_title"
    t.string   "email_template_subject"
    t.string   "email_template_content"
    t.integer  "lang_id"
    t.string   "active"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "mst_faqs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "question"
    t.string   "answer"
    t.string   "slug"
    t.string   "status"
    t.integer  "lang_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_how_it_works", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "slug"
    t.string   "description"
    t.string   "icon"
    t.integer  "lang_id"
    t.string   "status"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mst_newletters", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "newsletter_subject"
    t.string   "newsletter_content"
    t.integer  "lang_id"
    t.string   "status"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "mst_news", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "slug"
    t.text     "description", limit: 4294967295
    t.string   "url"
    t.string   "active"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "mst_permissions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mst_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mst_settings", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "key"
    t.string   "name"
    t.string   "description"
    t.string   "value"
    t.string   "field"
    t.string   "active"
    t.string   "lang_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "mst_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_email"
    t.string   "user_password"
    t.string   "role"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "trans_blog_comments", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "post_id"
    t.string   "commented_by"
    t.integer  "commented_user_id"
    t.string   "comment"
    t.string   "status"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "trans_blog_posts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "post_title"
    t.string   "seo_url"
    t.integer  "category_id"
    t.string   "post_short_description"
    t.string   "post_content"
    t.string   "page_title"
    t.string   "post_tags"
    t.string   "post_keyword"
    t.string   "posted_by"
    t.integer  "lang_id"
    t.string   "status"
    t.string   "blog_image"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "trans_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "category_name"
    t.string   "category_name_ch"
    t.string   "description"
    t.string   "category_icon"
    t.integer  "lang_id"
    t.integer  "category_id_fk"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "trans_newsletter_sends", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_email"
    t.integer  "user_id"
    t.integer  "newsletter_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "trans_newsletter_subscriptions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "user_email"
    t.string   "status"
    t.string   "user_subscription_code"
    t.integer  "is_subscribe_for_daily"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "trans_permission_roles", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "permission_id"
    t.integer  "role_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "trans_permission_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "permission_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "trans_role_users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "trans_user_informations", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "user_name"
    t.string   "user_mobile"
    t.string   "user_birth_date"
    t.string   "user_address"
    t.string   "user_zipcode"
    t.string   "profile_picture"
    t.string   "cover_picture"
    t.string   "about_me"
    t.string   "gender"
    t.string   "user_type"
    t.string   "user_status"
    t.string   "activation_code"
    t.string   "company_name"
    t.string   "designation"
    t.string   "provider"
    t.string   "provider_id"
    t.string   "promo_code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
