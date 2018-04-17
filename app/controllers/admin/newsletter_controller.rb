class Admin::NewsletterController < Admin::BaseController

  def list
  	ifAdminLoggedIn
  	@newletter = MstNewletter.group(:id).order(id: 'desc')
  	# render json: @newletter
  end

  def add
  	ifAdminLoggedIn
  end

  def create
  	ifAdminLoggedIn
  	@newletter = MstNewletter.create(
  					:newsletter_subject => params[:add_newsletter][:newsletter_subject],
  					:newsletter_content => params[:add_newsletter][:newsletter_content],
  					:lang_id => params[:add_newsletter][:lang_id],
  					:status => params[:add_newsletter][:status]
  				)
	flash[:success] = "Newsletter added successfully"
	redirect_to admin_newsletter_list_url
  end
  def edit
  	ifAdminLoggedIn
  	@newletter = MstNewletter.find_by(:id => Base64.decode64(params[:news_id]))
  	# render json: @newletter
  end

  def update
  	ifAdminLoggedIn
  	@newletter = MstNewletter.find_by(:id => Base64.decode64(params[:news_id]))
  	@newletter.update(
  		:newsletter_subject => params[:add_newsletter][:newsletter_subject],
			:newsletter_content => params[:add_newsletter][:newsletter_content],
			:lang_id => params[:add_newsletter][:lang_id],
			:status => params[:add_newsletter][:status]
  		)
  	flash[:success] = "Newsletter updated successfully"
	redirect_to admin_newsletter_list_url
  end	

  def destroy
  	ifAdminLoggedIn
  	@newletter = MstNewletter.find_by(:id => Base64.decode64(params[:news_id]))
  	if @newletter.blank? == false
  		@newletter.destroy
  	end	
  	flash[:success] = "Newsletter deleted successfully"
	redirect_to admin_newsletter_list_url
  end	

  def change_status
  	ifAdminLoggedIn
  	if params[:news_id] != ""
		@newletter = MstNewletter.find_by(:id => params[:news_id])
		if @newletter.nil? == false   
			@newletter.update(:status => params[:status].to_s)
			flash[:success]="Status Changed successfully"
			respond_to do |format|
				format.json { render :json => {"error" => "0", "error_message" => "Status Changed successfully"} }
			end
		else
			respond_to do |format|
				format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
			end
		end
	else 
		respond_to do |format|
			format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
		end
	end
  end

  def send_newsletter
  	ifAdminLoggedIn
  	@newletter = MstNewletter.find_by(:id => Base64.decode64(params[:news_id]))
  	# render json: @newletter
  end

  def send_newsletter_save
    ifAdminLoggedIn
    getGlobalData
    @user_status = params[:send_newsletter][:user_status]
    @newletter = MstNewletter.find_by(:id => Base64.decode64(params[:news_id]))
    if params[:send_newsletter][:attachement]
      @file_name = TransNewsletterSubscription.upload_image(params[:send_newsletter][:attachement])
    end  
    if params[:send_newsletter][:list_of_users]
      @emails = params[:send_newsletter][:list_of_users]
      @emails_for_newsletter = @emails.split(',')
    end
    @emails_for_newsletter.each do |emails|
      if @user_status == "0" || @user_status =="1" || @user_status == "2"
        @userinfo = MstUser.find_by(:user_email => emails.to_s)
        @sub_user = TransNewsletterSubscription.create(
            :user_email => emails.to_s,
            :status => "1",
            :user_subscription_code => Base64.encode64(Time.now.to_s),
            :is_subscribe_for_daily => "1"
          )
        @subject = @newletter.newsletter_subject
        @message = @newletter.newsletter_content
        @mail_details ={
          :to => emails,
          :from => @site_email,
          :subject => @subject,
          :body => @message
        }
        @directory = Rails.public_path.join('newsletter_attachment')
        if params[:send_newsletter][:attachement]
          @attachment = {
            :path =>  "/home/administrator/Documents/Sachin/ROR/p1051/public/newsletter_attachment/",
            :filename => @file_name
          }
        else
         @attachment = nil
        end  
        CommonMailer.send_email(@mail_details).deliver_now
      else
        @userinfo = TransNewsletterSubscription.find_by(:user_email => emails.to_s)
        @sub_user = TransNewsletterSubscription.create(
            :user_email => emails.to_s,
            :status => "1",
            :user_subscription_code => Base64.encode64(Time.now.to_s),
            :is_subscribe_for_daily => "1"
          )
        @subject = @newletter.newsletter_subject
        @message = @newletter.newsletter_content
        @mail_details ={
          :to => emails,
          :from => @site_email,
          :subject => @subject,
          :body => @message
        }
        # @directory = Rails.public_path.join('newsletter_attachment')
        if params[:send_newsletter][:attachement]
          @attachment = {
            :path =>  "/home/administrator/Documents/Sachin/ROR/p1051/public/newsletter_attachment/",
            :filename => @file_name
          }
        else
         @attachment = nil
        end  
        CommonMailer.send_email(@mail_details).deliver_now
      end
    end
    flash[:success] = "Newsletter send successfully"
    redirect_to admin_newsletter_list_url
    # render json: @directory
  end	

  def get_all_user_by_status
  	@user_status = params[:user_status]
  	if @user_status == "0" || @user_status =="1" || @user_status == "2"
  		  @user_data = MstUser
              .joins('INNER JOIN trans_user_informations u on u.user_id = mst_users.id')
              .select('GROUP_CONCAT(mst_users.user_email) as all_emails')
              .find_by('u.user_status' => @user_status)
    else 
        @user_status == "3"
        @subscribe_status = "1"
        @user_data = TransNewsletterSubscription
              .select('GROUP_CONCAT(user_email) as all_emails')
              .find_by(:status => @subscribe_status)
    end
    respond_to do |format|
      format.json { render :json => {"error" => "0", "user_emails" => @user_data.all_emails} }
    end  
  end	

  def subscriber_list
  	ifAdminLoggedIn
  	@newletter = TransNewsletterSubscription.group(:id)
  	# render json: @newletter
  end

  def subscriber_destroy
  	ifAdminLoggedIn
  	@newletter = TransNewsletterSubscription.find_by(:id => Base64.decode64(params[:sub_id]))
  	if @newletter.blank? == false
  		@newletter.destroy
  	end	
  	flash[:success] = "Newsletter subscribe deleted successfully"
	redirect_to admin_subscriber_list_url
  end	

  def subscriber_change_status
  	ifAdminLoggedIn
  	if params[:news_id] != ""
		@sub_newletter = TransNewsletterSubscription.find_by(:id => params[:sub_id])
		if @sub_newletter.nil? == false   
			@sub_newletter.update(:status => params[:status].to_s)
			flash[:success]="Status Changed successfully"
			respond_to do |format|
				format.json { render :json => {"error" => "0", "error_message" => "Status Changed successfully"} }
			end
		else
			respond_to do |format|
				format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
			end
		end
	else 
		respond_to do |format|
			format.json { render :json => {"error" => "1", "error_message" => "Sorry, your request can not be fulfilled this time. Please try again later"}}
		end
	end
  end

end
