class HomeController < ApplicationController
	require 'base64'
	require 'uri'	
	
	def index
		@page_title = "Home"
		@faq = MstFaq.where(:status => 1, :lang_id => current_lang_id).order(id: 'asc')
	end
	
	def cms_page
		if session[:user_id]
	        @user=MstUser.find_by(session[:user_id]);
	    end
		@lang_id = current_lang_id # should be the session lang id and not static
		@page_name = params[:page_name]
		@cms_data = MstContentPage.find_by(:slug => @page_name,:lang_id => @lang_id);
		if @cms_data.blank? == true
			flash[:error]= t("record_not_found_for_this_content_page")
			redirect_to root_url
		end
		if @page_name = "privacy"
			@page_title = "Privacy"
		elsif @page_name = "about-us"
			@page_title = "About Us"
		elsif @page_name = "partners"
			@page_title = "Partners"
		end	

	end

	def newsletter_sub
		if session[:user_id]
	        @user=MstUser.find_by(session[:user_id]);
	        @user_email = @user.user_email
	        @newsletter_sub = TransNewsletterSubscription.find_by(:user_email => @user_email);
	        if @newsletter_sub.blank? == false
	        	flash[:warning] = t("you_have_already_subscribed_for_newsletter")
	        	redirect_to root_url
	        else
	        	@newletter = TransNewsletterSubscription.create(
  					:user_email => @user_email.to_s,
		            :status => "0",
		            :user_subscription_code => Base64.encode64(Time.now.to_s),
		            :is_subscribe_for_daily => "1"
	        		)
	        	flash[:success] = t("you_have_successfully_subscribed_for_newsletter")
	        	redirect_to root_url
	        end	
	    else
	        if params[:newsletter][:user_email].blank? == false
		        @newsletter_sub = TransNewsletterSubscription.find_by(:user_email => params[:newsletter][:user_email]);
		        if @newsletter_sub.blank? == false
		        	flash[:warning] = t("you_have_already_subscribed_for_newsletter")
		        	redirect_to root_url
		        else
		        	@newletter = TransNewsletterSubscription.create(
	  					:user_email => params[:newsletter][:user_email],
			            :status => "0",
			            :user_subscription_code => Base64.encode64(Time.now.to_s),
			            :is_subscribe_for_daily => "1"
		        		)
		        	flash[:success] = t("you_have_successfully_subscribed_for_newsletter")
		        	redirect_to root_url
		        end	
		    else
		    	flash[:warning] = t("user_email_req_val")
		        redirect_to root_url
		    end    
	    end
	end	

	def get_subcategory
		cat_id = params[:cat_id].to_i
		lang_id = params[:lang_id]
		@subcategory = TransCategory
						.joins('INNER JOIN mst_categories as c on c.id = trans_categories.category_id_fk')
						.where('c.parent_id' => cat_id,:lang_id => 17)
		@subcategory_string='<option value="">'+(t('select_visa_type'))+'</option>'
		if lang_id == "17"
		    @subcategory.each do |s|
		      @subcategory_string+='<option value="'+s.category_id_fk.to_s+'">'+s.category_name+'</option>'
		    end
	    else
	    	@subcategory.each do |s|
	    	@subcategory_string+='<option value="'+s.category_id_fk.to_s+'">'+s.category_name_ch+'</option>'
	    end
	    end				
	    # @subcategory = TransState.where(:country_id => country_id)
	    respond_to do |format|
	      format.html { render :html => @subcategory_string.html_safe }
	    end
	end	

	def changeLanguage
    lang_code = params[:lang_code]
    session[:lang_code] = lang_code
    if lang_code == 'ch'
      cookies.permanent[:educator_locale] = :ch
    else
      cookies.permanent[:educator_locale] = :en
    end
    respond_to do |format|
      format.json { render :json => {"error_code"=>"0","msg"=>"session set"} }
    end
  end


end
