class RegisterController < ApplicationController
  def new
    @user_id = session[:user_id]
    if @user_id.nil? == false
      flash[:error] = "You are already logged in."
      redirect_to user_dashboard_url
    end
  end

  def create
    getGlobalData
    # render json:  @user
    if params[:signup]
      render json:  params[:signup]
      @password = Base64.encode64(params[:signup][:password])
      @email_id = params[:signup][:user_email]
      @email_address=@email_id.split('@')
      @my_username=@email_address[0];
      @activation_code = rand(36**8).to_s(36)
      @user = MstUser.create(
          :user_email => @email_id,
          :role => "2",
          :user_password => @password,
      );
      @user_information = TransUserInformation.create(
          :user_name => @my_username,
          :first_name => params[:signup][:first_name],
          :last_name => params[:signup][:last_name],
          :user_status => "0",
          :user_type => "2",
          :activation_code => Base64.encode64(@activation_code.to_s),
          :user_id => @user.id
      );

      @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-registration-successful')
      @subject = @email_template.email_template_subject
      @message = @email_template.email_template_content
      # @activation_code= @user_information[:activation_code]
      @user_signin = '<a href="'+ ( activate_account_url(:activation_code => Base64.encode64(@activation_code.to_s))) +'">HERE</a>'
      @reserve_words = [
          ["||SITE_TITLE||", @site_title],
          ["||SITE_PATH||" , root_url],
          ["||USER_NAME||" , params[:signup][:first_name]],
          ["||USER_EMAIL||", params[:signup][:user_email]],
          ["||PASSWORD||" , params[:signup][:password]],
          ["||LOGIN_URL||",@user_signin]
      ]
      # render json: @reserve_words
      @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
      @mail_details ={
          :to => params[:signup][:user_email],
          :from => @site_email,
          :subject => @subject,
          :body => @message
      }
      CommonMailer.send_email(@mail_details).deliver_now
      flash[:success]= "You account has been registered successfully."
      redirect_to signin_path
    else
      flash[:error]= "Something went wrong, please check your inputs and try again."
      redirect_to signup_path
    end
  end

  def login
  end

  def signin
    if session[:user_id]
      flash[:error] = "You are already logged in."
      redirect_to user_dashboard_url
    else
      @user_email = params[:signin][:user_email].to_s
      @password = params[:signin][:password].to_s

      @user = MstUser.find_by(:user_email => @user_email, :user_password => Base64.encode64(@password))
      # render json: @user
      if @user.blank?
        flash[:error] = t("invalid_email_or_password")
        redirect_to root_url
      else
        if @user.trans_user_informations.user_status != "1"
          flash[:error] = t("your_account_is_not_activated")
          redirect_to root_url
        else
          session[:user_id] = @user.id
          session[:user_name] = @user.trans_user_informations.user_name
          session[:user_email] = @user.user_email
          session[:first_name] = @user.trans_user_informations.first_name
          session[:user_type] = @user.trans_user_informations.user_type
          if params[:signin][:remember_me] == "1"
            # Set a cookie that expires in 1 hour
            cookies[:user_email] = { :value => params[:signin][:user_email], :expires => Time.now + (86400*7)}
            cookies[:password] = { :value => params[:signin][:password], :expires => Time.now + (86400*7)}
            cookies[:remember_me] = "1"
          else
            cookies.delete :user_email
            cookies.delete :password
            cookies[:remember_me] = "0"
          end
          redirect_to user_dashboard_url
        end
      end
    end
  end

  def check_email
    @user_email = params[:signup][:user_email]
    @user = MstUser.find_by(:user_email => @user_email)
    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  def check_user_name
    @user = TransUserInformation.find_by_user_name(params[:signup][:username])
    respond_to do |format|
      format.json { render :json => !@user }
    end
  end

  # def check_email
  #   @user_email = params[:update_user_email][:new_user_email]
  #   @user = MstUser.find_by(:user_email => @user_email)
  #   respond_to do |format|
  #     format.json { render :json => !@user }
  #   end
  # end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    session[:user_email] = nil
    session[:first_name] = nil
    session[:user_type] = nil
    flash[:success]= "You have logged out successfully."
    redirect_to root_url
  end

  def forgot_password

  end

  def reset_password
    getGlobalData
    @user_email = params[:forgot_password][:user_email]
    @user_data = MstUser
                     .joins('INNER JOIN trans_user_informations u on u.user_id = mst_users.id')
                     .select('u.*','mst_users.user_email','mst_users.user_password')
                     .find_by(:user_email => @user_email)
    if @user_data.blank? == false
      @user_name = @user_data.user_name
      @email_template = MstEmailTemplate.find_by(:email_template_title => 'forgot-password')
      @subject = @email_template.email_template_subject
      @message = @email_template.email_template_content
      # @activation_code= @user_information[:activation_code]
      @reset_password_link = '<a href="'+ ( reset_password_link_url(:user_email => Base64.encode64(@user_email))) +'">CLICK HERE</a>'
      @reserve_words = [
          ["||SITE_TITLE||", @site_title],
          ["||USER_NAME||" , @user_name],
          ["||RESET_PASSWORD_LINK||" , @reset_password_link]
      ]
      # render json: @reserve_words
      @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
      @mail_details ={
          :to => params[:forgot_password][:user_email],
          :from => @site_email,
          :subject => @subject,
          :body => @message
      }
      CommonMailer.send_email(@mail_details).deliver_now
      flash[:success] = t("please_check_your_email_for_reset_password")
      redirect_to root_url
    else
      flash[:error] = t("record_not_found")
      redirect_to root_url
    end
  end

  def reset_password_link
    @user_email = Base64.decode64(params[:user_email])
    @user_data = MstUser
                     .joins('INNER JOIN trans_user_informations u on u.user_id = mst_users.id')
                     .select('u.*','mst_users.user_email','mst_users.user_password')
                     .find_by(:user_email => @user_email)

  end

  def reset_password_save
    @user_email = params[:reset_password][:user_email]
    @password = params[:reset_password][:password]
    @user_data = MstUser.find_by(:user_email => @user_email)
    if @user_data.blank? == false
      @user_data.update(:user_password => Base64.encode64(@password))
      flash[:success] = t("your_password_changed_successfully")
      redirect_to root_url
    else
      flash[:error] = t("record_not_found_for_entered_email")
      redirect_to root_url
    end

  end

  def socialMediaLogin
    if params[:provider] == "facebook"
      @facebook_info = request.env["omniauth.auth"].info
      @authorized_user = MstUser.find_by(:user_email => @facebook_info.email.to_s)
      if @authorized_user.nil? == false then
        session[:user_id] = @authorized_user.id
        session[:user_name] = @authorized_user.trans_user_informations.user_name
        session[:user_email] = @authorized_user.user_email
        session[:first_name] = @authorized_user.trans_user_informations.first_name
        session[:user_type] = @authorized_user.trans_user_informations.user_type

        flash[:success] = t("logged_in_successfully")
        redirect_to user_dashboard_url
      else
        @user_pass = SecureRandom.hex(3)
        @password = Base64.encode64(@user_pass).gsub!(/\n+/, "")
        @email_id = @facebook_info.email
        @email_address=@email_id.split('@')
        @my_username=@email_address[0];
        @name = @facebook_info.name.split(' ')
        @user = MstUser.create(
            :user_email => (@email_id !='') ? @email_id : "",
            :role => "2",
            :user_password => @password,
        );
        if session[:user] == "customer"
          @user_type = "2"
        elsif session[:user] == "promoter"
          @user_type = "3"
        end
        @user_information = TransUserInformation.create(
            :user_name => @my_username,
            :first_name => @name[0],
            :last_name => @name[1],
            :user_status => "1",
            :user_type => @user_type.to_s,
            # :email_verified => 1,
            # :email_notification => 1,
            :activation_code => Base64.encode64(Time.now.to_s),
            :user_id => @user.id,
            :provider => request.env["omniauth.auth"].provider,
            :provider_id => request.env["omniauth.auth"].uid
        );
        @to_useremail = @email_id
        @to_username = @my_username
        @user_pass = @user_pass

        send_signup_notification(@to_useremail, @to_username, @user_pass)

        session[:user_id] = @user_information.id
        session[:user_name] = @user_information.user_name
        session[:user_email] = @user.user_email
        session[:first_name] = @user_information.first_name
        session[:user_type] = @user_information.user_type

        flash[:success]= t("you_have_successfully_registered")
        redirect_to user_dashboard_url
      end
    elsif params[:provider] == "google_oauth2"
      @google_info = request.env["omniauth.auth"].info
      @authorized_user = MstUser.find_by(:user_email => @google_info.email.to_s)
      if @authorized_user.nil? == false then
        session[:user_id] = @authorized_user.id
        session[:user_name] = @authorized_user.trans_user_informations.user_name
        session[:user_email] = @authorized_user.user_email
        session[:first_name] = @authorized_user.trans_user_informations.first_name
        session[:user_type] = @authorized_user.trans_user_informations.user_type

        flash[:success] = t("logged_in_successfully")
        redirect_to user_dashboard_url
      else
        @user_pass = SecureRandom.hex(3)
        @password = Base64.encode64(@user_pass).gsub!(/\n+/, "")
        @email_id = @google_info.email
        @email_address=@email_id.split('@')
        @my_username=@email_address[0];
        @user = MstUser.create(
            :user_email => (@email_id !='') ? @email_id : "",
            :role => "2",
            :user_password => @password,
        );
        if session[:user] == "customer"
          @user_type = "2"
        elsif session[:user] == "promoter"
          @user_type = "3"
        end
        @user_information = TransUserInformation.create(
            :user_name => @my_username,
            :first_name => @name[0],
            :last_name => @name[1],
            :user_status => "1",
            :user_type => @user_type.to_s,
            # :email_verified => 1,
            # :email_notification => 1,
            :activation_code => Base64.encode64(Time.now.to_s),
            :user_id => @user.id,
            :provider => request.env["omniauth.auth"].provider,
            :provider_id => request.env["omniauth.auth"].uid
        );
        ###############SEND NOTIFICATION##############
        @to_useremail = @email_id
        @to_username = @my_username
        @user_pass = @user_pass
        send_signup_notification(@to_useremail, @to_username, @user_pass)
        ##############################################
        session[:user_id] = @user_information.id
        session[:user_name] = @user_information.user_name
        session[:user_email] = @user.user_email
        session[:first_name] = @user_information.first_name
        session[:user_type] = @user_information.user_type

        flash[:success]= t("you_have_successfully_registered")
        redirect_to contact_us_url
      end
    end
  end

  def social_auth
    # render :text => request.env["omniauth.auth"].to_yaml
  end

  def send_signup_notification(to, user_name, password)
    getGlobalData
    @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-registration-successful')
    @subject = @email_template.email_template_subject
    @message = @email_template.email_template_content
    # @activation_code= @user_information[:activation_code]
    @user_signin = '<a href="'+ ( root_url ) +'">HERE</a>'
    @reserve_words = [
        ["||SITE_TITLE||", @site_title],
        ["||SITE_PATH||" , root_url],
        ["||USER_NAME||" , @to_username],
        ["||USER_EMAIL||", @to_useremail],
        ["||PASSWORD||" , @user_pass],
        ["||LOGIN_URL||",@user_signin]
    ]
    # render json: @reserve_words
    @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
    @mail_details ={
        :to => @to_useremail,
        :from => @site_email,
        :subject => @subject,
        :body => @message
    }
    CommonMailer.send_email(@mail_details).deliver_now
  end


  def activate_account
    @activation_code = params[:activation_code]
    if session[:user_id]
      flash[:error] = t("you_are_already_logged_in")
      redirect_to user_dashboard_url
    else
      @user_data = TransUserInformation.find_by(:activation_code => @activation_code)
      if @user_data.blank? == false
        @user_data.update(:user_status => "1");
      end
      flash[:success] = t("acc_activate_thr_email")
      redirect_to root_url
    end
  end

  def checkout_user_login
    if session[:user_id]
      # flash[:error] = t("you_are_already_logged_in")
      @error_code = t("you_are_already_logged_in")
      respond_to do |format|
        format.json { render :json => {:error => @error_code } }
      end
    else
      @user_email = params[:user_email].to_s
      @password = params[:password].to_s
      @user = MstUser.find_by(:user_email => @user_email, :user_password => Base64.encode64(@password))
      if @user.nil?
        @error_code = t("invalid_email_or_password")
        respond_to do |format|
          format.json { render :json => {:error => @error_code } }
        end
      else
        if @user.trans_user_informations.user_status != "1"
          @error_code = t("your_account_is_not_activated")
          respond_to do |format|
            format.json { render :json => {:error => @error_code } }
          end
        else
          session[:user_id] = @user.id
          session[:user_name] = @user.trans_user_informations.user_name
          session[:user_email] = @user.user_email
          session[:first_name] = @user.trans_user_informations.first_name
          session[:user_type] = @user.trans_user_informations.user_type
          # if params[:signin][:remember_me] == "1"
          #     # Set a cookie that expires in 1 hour
          #     cookies[:user_email] = { :value => params[:signin][:user_email], :expires => Time.now + (86400*7)}
          #     cookies[:password] = { :value => params[:signin][:password], :expires => Time.now + (86400*7)}
          #     cookies[:remember_me] = "1"
          # else
          #   cookies.delete :user_email
          #   cookies.delete :password
          #   cookies[:remember_me] = "0"
          # end
          respond_to do |format|
            format.json { render :json => {:error => "", :uname => @user.trans_user_informations.user_name, :userid => @user.id, :edit_link =>edit_profile_url(:user_id => Base64.encode64(@user.id.to_s)), :profile_link => user_dashboard_url, :logout_link => user_logout_url, :first_name => @user.trans_user_informations.first_name, :last_name => @user.trans_user_informations.last_name, :user_email => @user.user_email, :user_mobile => @user.trans_user_informations.user_mobile } }
          end
        end
      end
    end
  end
end