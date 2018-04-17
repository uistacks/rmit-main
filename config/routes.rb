Rails.application.routes.draw do

  namespace :admin do
    root 'admin#index'
    
    #----ADMIN ROUTE START HERE----#
    get 'index' => 'admin#index', as: :dashboard
    get 'admin-list' => 'admin#list', as: :list
    get 'admin-add' => 'admin#add', as: :add
    post 'admin/create' => 'admin#create', as: :create
    get 'admin-show/(:user_id)' => 'admin#show', as: :show
    get 'admin-edit/(:user_id)' => 'admin#edit', as: :edit
    post 'admin-update' => 'admin#update', as: :update
    post 'admin-password-update' => 'admin#update_password', as: :update_password
    get 'admin-login' => 'admin#login', as: :login
    post 'admin-attempt-login' => 'admin#attempt_login', as: :attempt_login
    get 'forgot-password' => 'admin#forgot_password', as: :forgot_password
    post 'reset-password' => 'admin#reset_password', as: :reset_password
    get 'admin-logout' => 'admin#logout', as: :logout
    get "admin-destroy/(:user_id)", to:"admin#destroy", as:"destroy"

    post 'admin/update-photo/(:user_id)' => 'admin#update_photo', as: :update_photo
    get 'admin/update-default-photo/(:user_id)/(:p_type)' => 'admin#update_default_photo', as: :update_default_photo
    #----ADMIN ROUTE END HERE----#
    #----MANAGE ROLE ROUTE START HERE----#
    get 'role/list' => 'role#list', as: :role_list
    get 'role/add' => 'role#add', as: :role_add
    post 'role/create' => 'role#create', as: :role_create
    get 'role/edit/(:role_id)' => 'role#edit', as: :role_edit
    post 'role/update/(:role_id)' => 'role#update', as: :role_update
    get 'role/destroy/(:role_id)' => 'role#destroy', as: :role_destroy
    get "role/check-role", to:"role#check_role", as:"check_role"
    get "role/permission", to:"role#permission", as: :role_permission
    post 'role/update-permission/(:role_id)' => 'role#update_permission', as: :role_permission_update
    #----MANAGE ROLE ROUTE END HERE----#
    #----MANAGE PERMISSION ROUTE START HERE----#
    get 'permission/list' => 'permission#list', as: :permission_list
    get 'permission/add' => 'permission#add', as: :permission_add
    post 'permission/create' => 'permission#create', as: :permission_create
    get 'permission/edit/(:p_id)' => 'permission#edit', as: :permission_edit
    # post 'permission/update/(:p_id)' => 'permission#update', as: :permission_update
    # get 'permission/destroy/(:role_id)' => 'permission#destroy', as: :permission_destroy
    # get "role/check-role", to:"permission#check_role", as:"check_role"
    #----MANAGE PERMISSION ROUTE END HERE----#
    #----GLOBAL SETTING ROUTE START HERE----#
    get 'setting/list' => 'setting#list', as: :global_setting_list
    get 'setting/edit/(:global_id)' => 'setting#edit', as: :global_setting_edit
    post 'setting-update/(:global_id)' => 'setting#update', as: :update_global_settings
    #----GLOBAL SETTING ROUTE END HERE----#
    #----CONTENT PAGE ROUTE START HERE----#
    get 'content-page/list' => 'content_page#list', as: :content_page_list
    get 'content-page/edit/(:cms_id)' => 'content_page#edit', as: :content_page_edit
    post 'content-page/update/(:cms_id)' => 'content_page#update', as: :content_page_update
    get 'content-page/edit-multilanguage/(:slug)' => 'content_page#edit_multilang', as: :content_page_edit_multilang
    post 'content-page/update-multilanguage/(:cms_id)' => 'content_page#update_multilang', as: :content_page_update_multilang
    get 'content-page/check' => 'content_page#check_title', as: :content_check_title
    #----CONTENT PAGE ROUTE END HERE----#
    #----EMAIL TEMPLATE ROUTE START HERE----#
    get 'email-template/list' => 'email_template#list', as: :email_template_list
    get 'email-template/edit/(:email_id)' => 'email_template#edit', as: :email_template_edit
    post 'email-template/update/(:email_id)' => 'email_template#update', as: :email_template_update
    get 'email-template/edit-multilanguage/(:temp_title)' => 'email_template#edit_multilang', as: :edit_email_template_multilang
    post 'email-template/update-multilanguage/(:email_id)' => 'email_template#update_multilang', as: :update_email_template_multilang
    #----EMAIL TEMPLATE ROUTE END HERE----#
#----USER ROUTE START HERE----#
    get 'user/list/(:type)' => 'user#list', as: :user_list
    get 'user/add/(:type)' => 'user#new', as: :add_user
    post 'user/create' => 'user#create', as: :create_user
    get 'user/edit/(:user_id)/(:type)' => 'user#edit', as: :user_edit
    post 'user/update/(:user_id)/(:type)' => 'user#update', as: :user_update
    post 'user-password-update/(:type)' => 'user#update_password', as: :update_user_password
    post 'user/update-photo/(:user_id)/(:type)' => 'user#update_photo', as: :user_update_photo
    get 'user/update-default-photo/(:user_id)/(:p_type)/(:type)' => 'user#update_default_photo', as: :user_update_default_photo
    get 'user/show/(:user_id)/(:type)' => 'user#show', as: :user_show
    get 'user/promoter-credit/(:user_id)/(:type)' => 'user#promoter_credit_list', as: :promoter_credit
    #check email
    get "user/check-email", to:"user#check_email", as:"check_user_email"
    get "user/check-edit-email", to:"user#check_edit_email", as:"check_edit_user_email"
    #check username
    get "user/check_user_name", to:"user#check_user_name", as:"check_user_name"
    get "user/check_edit_username", to:"user#check_edit_username", as:"check_edit_username"
    #change user status
    get "user/change-status", to:"user#change_status", as:"change_user_status"
    get "user/user-destroy/(:user_id)/(:type)", to:"user#destroy", as:"destroy_user"
    #----USER ROUTE END HERE----#
    #----category route start here----#
    get "category/list" => "category#list", as: :category_list
    get "category/add" => "category#add", as: :add_category
    post "category/create" => "category#create", as: :create_category
    get "category/check-category-name" => "category#check_category_name" , as: :check_category_name
    get "category/edit/(:cat_id)" => "category#edit", as: :edit_category
    post "category/update/(:cat_id)" => "category#update", as: :update_category
    get "category/edit-multilanguage/(:cat_id)" => "category#edit_multilang", as: :edit_multilang_category
    post "category/update-multilanguage/(:cat_id)" => "category#update_multilang", as: :update_multilang_category
    get "category/destroy/(:cat_id)", to:"category#destroy", as:"destroy_category"
    get "category/list-sub-category/(:cat_id)" => "category#list_subcategory", as: :subcategory_list
    get "category/add-sub-category/(:cat_id)" => "category#add_subcategory", as: :add_subcategory
    post "category/create-sub-category/(:cat_id)" => "category#create_subcategory", as: :create_subcategory
    get "category/check-subcategory-name" => "category#check_subcategory_name" , as: :check_subcategory_name
    get "category/edit-sub-category/(:subcat_id)/(:cat_id)" => "category#edit_subcategory", as: :edit_subcategory
    post "category/update-sub-category/(:subcat_id)/(:cat_id)" => "category#update_subcategory", as: :update_subcategory
    # get "category/edit-sub-category-multilanguage/(:subcat_id)/(:cat_id)" => "category#edit_multilang_subcategory", as: :edit_multilang_subcategory
    # post "category/update-sub-category-multilanguage/(:subcat_id)/(:cat_id)" => "category#update_multilang_subcategory", as: :update_multilang_subcategory
    get "category/destroy-sub-category/(:subcat_id)/(:cat_id)", to:"category#destroy_subcategory", as:"destroy_subcategory"

    #---category route end here----#

    #---faq route start here----#
    get "faq/list" => "faq#list", as: :faq_list
    get "faq/faq-change-status" => "faq#change_status", as: :faq_change_status
    get "faq/add" => "faq#add", as: :faq_add
    post "faq/create" => "faq#create", as: :faq_create
    get "faq/edit/(:faq_id)" => "faq#edit", as: :faq_edit
    post "faq/update/(:faq_id)" => "faq#update", as: :faq_update
    get "faq/edit-multilanguage/(:slug)" => "faq#edit_multi", as: :faq_edit_multi
    post "faq/update-multilanguage/(:slug)" => "faq#update_multi", as: :faq_update_multi
    get "faq/delete/(:faq_id)" => "faq#destroy", as: :faq_destroy
    #---faq route end here----#

    #---blog route start here----#
    get "blog-post/list" => "blog#list", as: :blog_list
    get "blog-post/add" => "blog#add", as: :blogpost_add
    post "blog-post/create" => "blog#create", as: :blogpost_create
    get "blog-post/edit/(:post_id)" => "blog#edit", as: :blogpost_edit
    post "blog-post/update/(:post_id)" => "blog#update", as: :blogpost_update
    get "blog-post/destroy/(:post_id)" => "blog#destroy", as: :blogpost_destroy
    get "blog-post/comment/list/(:post_id)" => "blog#list_comment", as: :comment_list
    get "blog-post/comment/edit/(:comment_id)" => "blog#edit_comment", as: :comment_edit
    post "blog-post/comment/update/(:comment_id)" => "blog#update_comment", as: :comment_update
    get "blog-post/comment/add/(:post_id)" => "blog#add_comment", as: :comment_add
    post "blog-post/comment/create/(:post_id)" => "blog#create_comment", as: :comment_create
    get "blog-post/comment/destroy/(:comment_id)/(:post_id)" => "blog#destroy_comment", as: :comment_destroy
    #---blog route end here----#

    #---newsletter route start here----#
    get "newsletter/list" => "newsletter#list", as: :newsletter_list
    get "newsletter/add" => "newsletter#add", as: :newsletter_add
    post "newsletter/create" => "newsletter#create", as: :newsletter_create
    get "newsletter/edit/(:news_id)" => "newsletter#edit", as: :newsletter_edit
    post "newsletter/update/(:news_id)" => "newsletter#update", as: :newsletter_update
    get "newsletter/delete/(:news_id)" => "newsletter#destroy", as: :newsletter_destroy
    get "newsletter/change-status" => "newsletter#change_status", as: :newsletter_change_status
    get "newsletter/send/(:news_id)" => "newsletter#send_newsletter", as: :newsletter_send
    post "newsletter/send-save/(:news_id)" => "newsletter#send_newsletter_save", as: :newsletter_send_save
    get "newsletter/get-all-users" => "newsletter#get_all_user_by_status", as: :newsletter_getallusersbystatus
    get "newsletter/subscriber/list" => "newsletter#subscriber_list", as: :subscriber_list
    get "newsletter/subscriber/delete/(:sub_id)" => "newsletter#subscriber_destroy", as: :subscriber_destroy
    get "newsletter/subscriber/change-status" => "newsletter#subscriber_change_status", as: :subscriber_change_status
    
    #---newsletter route end here----#
    #----PRODUCT ROUTE START HERE----#
    #get 'product/list/(:user_id)/(:type)' => 'product#list', as: :product_list
    get 'product/list' => 'product#list', as: :product_list
    get 'product/get-subcategory' => 'product#get_subcategory', as: :get_subcategory
    get 'product/new' => 'product#new', as: :add_product
    post 'product/import' => 'product#import', as: :import_products
    post 'product/create' => 'product#create', as: :create_product
    get 'product/edit/(:product_id)' => 'product#edit', as: :edit_product
    post 'product/update/(:product_id)' => 'product#update', as: :update_product
    get "product/delete-product/(:product_id)" => "product#destroy", as: :destroy_product
    get "product/sold-product/(:product_id)" => "product#list_sold_product", as: :list_sold_product
    
    #----PRODUCT ROUTE END HERE----#

    #----PARTNER ROUTE START HERE----#
    get 'partner/list' => 'partner#list', as: :partner_list
    get 'partner/add' => 'partner#add', as: :add_partner
    post 'partner/create' => 'partner#create', as: :create_partner
    get 'partner/edit/(:partner_id)' => 'partner#edit', as: :edit_partner
    post 'partner/update/(:partner_id)' => 'partner#update', as: :update_partner
    get "partner/delete/(:partner_id)" => "partner#destroy", as: :destroy_partner
    get "partner/change-status" => "partner#change_status", as: :change_partner_status
    get "partner/check-partner-name" => "partner#check_name", as: :check_partner_name
    #----PARTNER ROUTE END HERE----#

    #----HOW-IT-WORK ROUTE START HERE----#
    get 'how-it-works/list' => 'how_it_work#list', as: :how_it_work_list
    get 'how-it-works/add' => 'how_it_work#add', as: :add_how_it_work
    post 'how-it-works/create' => 'how_it_work#create', as: :create_how_it_work
    get 'how-it-works/edit/(:how_id)' => 'how_it_work#edit', as: :edit_how_it_work
    post 'how-it-works/update/(:how_id)' => 'how_it_work#update', as: :update_how_it_work
    get 'how-it-works/edit-multilanguage/(:slug)' => 'how_it_work#edit_multi', as: :edit_multi_how_it_work
    post 'how-it-works/update-multilanguage/(:slug)' => 'how_it_work#update_multi', as: :update_multi_how_it_work
    get "how-it-works/delete/(:how_id)" => "how_it_work#delete", as: :destroy_how_it_work
    get "how-it-works/change-status" => "how_it_work#change_status", as: :how_change_status
    #----HOW-IT-WORK ROUTE END HERE----#

    #----contactus ROUTE START HERE----#
    get 'contactus/list' => 'contactus#list', as: :contactus_list
    get 'contactus/view/(:cont_id)' => 'contactus#view', as: :contactus_view
    post 'contactus/send' => 'contactus#send_contactus', as: :contactus_send
    get "contactus/delete/(:cont_id)" => "contactus#destroy", as: :contactus_destroy
    #----contactus ROUTE END HERE----#

    #----Quiz ROUTE START HERE----#
    get 'quiz/list' => 'quiz#list', as: :quiz_list
    get 'quiz/add-question' => 'quiz#add', as: :add_question
    post 'quiz/create-question' => 'quiz#create', as: :create_question
    get 'quiz/edit-question/(:que_id)' => 'quiz#edit', as: :edit_question
    post 'quiz/update-question/(:slug)' => 'quiz#update', as: :update_question
    get 'quiz/edit-multilang-question/(:slug)' => 'quiz#edit_multi', as: :edit_multi_question
    post 'quiz/update-multilang-question/(:que_id)' => 'quiz#update_multi', as: :update_multi_question
    get 'quiz/delete-question/(:que_id)' => 'quiz#destroy', as: :destroy_question
    get "quiz/change-status" => "quiz#change_status", as: :question_change_status
    #----Quiz ROUTE END HERE----#

    #----Transaction History Start Here----#
    get 'transaction/list' => 'transaction#list', as: :transaction_list
    get 'transaction/view/(:trans_id)' => 'transaction#view', as: :transaction_view
    get 'transaction/admin-credit' => 'transaction#admin_credit', as: :credit_list
    
    #----Transaction History End Here----#

    #----Payment Request Start Here----#
    get 'payment-request/list' => 'transaction#pay_request_list', as: :pay_request_list
    get 'payment-request/withdrawal' => 'transaction#promoter_payment', as: :promoter_payment
    get 'payment-request/save-withdrawal' => 'transaction#save_promoter_payment', as: :save_promoter_payment

    #----Payment Request End Here----#

    #----Order start Here----#    
    get 'order/list' => 'transaction#order_list', as: :order_list
    get 'order/view/(:order_id)' => 'transaction#order_view', as: :order_view
    #----Order end Here----#
    

    #----Transaction History Start Here----#
    # get 'transaction/list' => 'transaction#list', as: :transaction_list
    # get 'transaction/view/(:trans_id)' => 'transaction#view', as: :transaction_view
    
    #----Transaction History End Here----#

  end

  #==============FRONTEND ROUTE START HERE=================#

  root 'home#index'
  get 'home' => 'home#index', as: :home
  # get 'cms-page/:page_name' => 'cms_page', as: :cms_page
  get 'cms-page/(:page_name)', to: "home#cms_page", as: "cms_page"
  get 'get-subcategory' => 'home#get_subcategory', as: :get_subcategory
  get 'signup' => 'register#new', as: :signup
  post 'register/create/(:user)' => 'register#create', as: :signup_create
  get 'signin/(:user)' => 'register#login', as: :signin
  get 'register/customer/check-email' => 'register#check_email_cust', as: :check_user_email_cust
  get 'register/promoter/check-email' => 'register#check_email_promo', as: :check_user_email_promo
  get 'register/check-email' => 'register#check_email', as: :check_user_email
  get 'register/check-user-name' => 'register#check_user_name', as: :check_user_name
  post 'register/login' => 'register#signin', as: :user_login
  get 'logout' => 'register#logout', as: :user_logout
  get 'forgot-password' => 'register#forgot_password', as: :forgot_password
  post 'reset-password' => 'register#reset_password', as: :reset_password
  get 'reset-password-link/(:user_email)' => 'register#reset_password_link', as: :reset_password_link
  post 'reset-password-save' => 'register#reset_password_save', as: :reset_password_save
  get 'activate-account/(:activation_code)' => 'register#activate_account', as: :activate_account
  get 'check-checkout-login' => 'register#checkout_user_login', as: :checkout_user_login

  #----------------------user-account----------------------#
  get 'user/dashboard' => 'user_account#dashboard', as: :user_dashboard
  get 'user/edit-profile/(:user_id)' => 'user_account#edit_profile', as: :edit_profile
  post 'user/update-profile/(:user_id)' => 'user_account#update_profile', as: :update_profile
  get 'user/edit-account-setting/(:user_id)' => 'user_account#edit_email_address',as: :edit_user_email
  post 'user/update-account-email/(:user_id)' => 'user_account#update_email_address', as: :update_user_email
  post 'user/update-account-password/(:user_id)' => 'user_account#update_password', as: :update_password
  post 'user/update-photo/(:user_id)' => 'user_account#update_photo', as: :update_photo
  get 'user/update-default-photo/(:user_id)/(:p_type)' => 'user_account#update_default_photo', as: :update_default_photo
  get 'user/sale-chart' => 'user_account#charts', as: :sale_chart
  get 'user/customer-become-promoter' => 'user_account#cust_become_promoter', as: :cust_become_promoter
  get 'user/save-customer-become-promoter' => 'user_account#save_cust_become_promoter', as: :save_cust_become_promoter
  get 'user/promoter-wallet' => 'user_account#promoter_wallet', as: :promoter_wallet
  post 'user/promoter-payment-request/(:user_id)' => 'user_account#payment_request', as: :pay_request
  get 'user/promoter-wallet' => 'user_account#cust_order_detail', as: :cust_order_detail

  
  #change language
  get "change-language", to:"home#changeLanguage", as:"change_language"

  #----------------------blog----------------------#
  get "blog" => "blog#index", as: :blog
  get "blog/(:seo_url)" => "blog#detail", as: :blog_details
  post "blog/comment" => "blog#comment", as: :blog_comment
  post 'blog/blog-search', to:"blog#blog_search",as: :blog_search

  #----------------------conactus----------------------#
  get "contact-us" => "contactus#index", as: :contactus
  post "contact-us/create" => "contactus#create", as: :create_contactus

  #----------------------newsletter subscription----------------------#
  post "newsletter/subscription" => "home#newsletter_sub", as: :newsletter_sub

   #----------------------product subscription----------------------#
  get "product/list" => "product#list", as: :front_product_list

  #-----------social auth--------------
  get 'auth/:provider/callback' => 'register#socialMediaLogin', as: :social_login
  get 'auth/:provider' => 'register#social_auth', as: :auth_login
  post 'save-social-data' => 'register#social_user', as: :social_user

  get 'sample' => 'product#sample', as: :smaple
  
  #news template
  get "submit" => "news#new", as: :submit
  post "submit-news" => "news#create", as: :submit_news

end
