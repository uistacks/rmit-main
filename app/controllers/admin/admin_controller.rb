class Admin::AdminController < Admin::BaseController
  # layout false, only: [:login]
  def index
    ifAdminLoggedIn
    @total_admins=TransUserInformation.select(:id).where(:user_type => "1")
    @admin_data = MstUser.find_by(:id => 1)
    @total_customer=TransUserInformation.select(:id).where(:user_type => "2")
    @total_promoter=TransUserInformation.select(:id).where(:user_type => "3")
    @total_msg=MstContactu.select(:id).where(:status => "0")

  end

  def list
    ifAdminLoggedIn
    @user = MstUser.where.not(:role => "2").order(id: 'asc')
    # render json: @user.trans_role_users
  end

  def add
    ifAdminLoggedIn
  end
  
  def create
    ifAdminLoggedIn
    # @user_pass = SecureRandom.hex(3)
    @password = Base64.encode64(params[:user][:password])
    @email_id = params[:user][:user_email]
    @email_address=@email_id.split('@')
    @my_username=@email_address[0];
    @user = MstUser.create(
    :user_email => @email_id,
    :role => params[:user][:role_name],
    :user_password => @password,
    );
    @user_information = TransUserInformation.create(
    :user_name => params[:user][:username],
    :first_name => params[:user][:first_name],
    :last_name => params[:user][:last_name],
    :user_status => params[:user][:user_status],
    :user_type => "1", #SubAdmin
    :activation_code => Time.now,
    :user_id => @user.id
    );
    # attach a role to this user start
    TransRoleUser.create(
      :user_id => @user.id,
      :role_id => params[:user][:role_name],
    );
    # attach a role to this user end
    @email_template = MstEmailTemplate.find_by(:email_template_title => 'admin-added')
    @subject = @email_template.email_template_subject
    @message = @email_template.email_template_content
    @activation_code= @user_information[:activation_code]
    @user_signin = '<a href="'+ ( admin_login_url ) +'">HERE</a>'
    @reserve_words = [
      ["||SITE_TITLE||", @site_title],
      ["||SITE_PATH||" , admin_root_url],
      ["||USER_NAME||" , params[:user][:username]],
      ["||USER_EMAIL||", params[:user][:user_email]],
      ["||PASSWORD||" , params[:user][:password]],
      ["||LOGIN_URL||",@user_signin]
    ]
    @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
    @mail_details ={
      :to => params[:user][:user_email],
      :from => @site_email,
      :subject => @subject,
      :body => @message
    }
    # @attachment = {
    #   :path = '',
    #   :filename = ''
    # }
    CommonMailer.send_email(@mail_details).deliver_now
    flash[:success]= "Record Added successfully....!"
    redirect_to admin_list_url
  end
  def edit
    ifAdminLoggedIn
    @admin = MstUser.find_by(:id => Base64.decode64(params[:user_id]))
    if @user_account.role.to_s != "1" and @user_account.id != @admin.id then
      flash[:warning] = "You are not authorize to edit this user."
      redirect_to admin_root_url
    end
  end
  def update
    ifAdminLoggedIn
    @admin = MstUser.find_by(:id => params[:user][:edit_id])
    if @admin.nil?
      flash[:error]="Record not found....!"
      redirect_to admin_list_url
    else
      if @admin.role.to_s == "1" then
        @admin.update(
        :user_email => params[:user][:user_email],
        )
        @admin.trans_user_informations.update(
        :user_name => params[:user][:username],
        :first_name => params[:user][:first_name],
        :last_name => params[:user][:last_name]
        )
      else
        @admin.update(
          :user_email => params[:user][:user_email],
          :role => params[:user][:role_name]
          )
          @admin.trans_user_informations.update(
          :user_name => params[:user][:username],
          :first_name => params[:user][:first_name],
          :last_name => params[:user][:last_name],
          :user_status => params[:user][:user_status]
          )
          # update a role for this user
          @get_role = TransRoleUser.find_by(:user_id => params[:user][:edit_id])
          @get_role.update(
            :role_id => params[:user][:role_name],
          );
      end
      # session[:user_name] = @admin.trans_user_informations.user_name
      # session[:user_email] = @admin.user_email
      # session[:first_name] = @admin.trans_user_informations.first_name
      flash[:success]="Record Updated successfully....!"
      redirect_to admin_list_url
    end
  end
  def update_password
    ifAdminLoggedIn
    @admin = MstUser.find_by(:id => params[:admin_pass][:edit_id])
    if @admin.nil? == true
      flash[:error]="Record not found....!"
      redirect_to admin_list_url
    else
      @admin.update(
      :user_password => Base64.encode64(params[:admin_pass][:password])
      )
      flash[:success]="Password Updated successfully....!"
      redirect_to admin_list_url
    end
  end
  def show
    ifAdminLoggedIn
    @admin = MstUser.find_by(:id => Base64.decode64(params[:user_id]))
    if @user_account.role.to_s != "1" and @user_account.id != @admin.id then
      flash[:warning] = "You are not authorize to view this user."
      redirect_to admin_root_url
    end
  end

  def login
    if session[:user_id].nil? == false and session[:user_type] == "1"
      flash[:warning] = "You are already logged in."
      redirect_to admin_dashboard_url
    end
    # render json: "TEST23"
  end
  #attempt login
  def attempt_login
    # render json: params[:login]
    @authorized_user = MstUser.find_by(:user_email => params[:login][:user_email],:user_password => Base64.encode64(params[:login][:user_password]))
    # if @authorized_user.id.nil? == false
    #   session[:user_id] = @authorized_user.id
    #   render json: @authorized_user.trans_user_informations
    # else
    #   render json: "Something went wrong."
    # end
    if @authorized_user.nil?
      flash[:warning] = "Authentication Failed!, Please enter a valid credentials."
      redirect_to admin_login_url
    else
      @data = @authorized_user.trans_user_informations.user_name
      session[:user_id] = @authorized_user.id
      session[:user_name] = @authorized_user.trans_user_informations.user_name
      session[:user_email] = @authorized_user.user_email
      session[:role] = @authorized_user.role
      session[:first_name] = @authorized_user.trans_user_informations.first_name
      session[:user_type] = @authorized_user.trans_user_informations.user_type
      flash[:success] = "Logged in Successfully...!"
      redirect_to admin_dashboard_url
    end
  end
  def forgot_password
    if session[:user_id].nil? == false and session[:user_type] == "1"
      flash[:warning] = "You are already logged in."
      redirect_to admin_dashboard_url
    end
  end

  def reset_password
	getGlobalData
    @admin = MstUser.find_by(:user_email => params[:admin][:user_email])
    if @admin.nil?
      flash[:error] = "Invalid Email Id"
      redirect_to admin_forgot_password_url
    else
      @user_info = @admin.trans_user_informations
      if @user_info.user_type == "1"
        @user_name= @user_info.user_name
        @password = Base64.decode64(@admin.user_password)
        @email_template = MstEmailTemplate.find_by(:email_template_title => 'admin-forgot-password')
        @subject = @email_template.email_template_subject
        @message = @email_template.email_template_content
        @reserve_words = [
          ["||SITE_TITLE||", @site_title],
          ["||SITE_PATH||" , root_url],
          ["||USER_NAME||" , params[:admin][:user_email]],
          ["||ADMIN_NAME||" , (@user_info.first_name) +" "+ (@user_info.last_name)],
          ["||PASSWORD||" , @password]
        ]
        @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
        @mail_details ={
          :to => @admin.user_email,
          :from => @site_email,
          :subject => @subject,
          :body => @message
        }
        CommonMailer.send_email(@mail_details).deliver_now
        flash[:success] = "Login details are successfully sent on " + (@admin.user_email)
        redirect_to admin_login_url
      else
        flash[:error] = "You are not allowed reset password from this area."
        redirect_to admin_forgot_password_url
      end
    end
  end

  #change user picture
  def update_photo
    # @user_id = params[:user_id]
    @user_id = params[:update_photo][:user_id]
    @img_binary_data = params[:update_photo][:imagebase64]
    @img_binary_data = @img_binary_data.split(';')
    @img_binary_data = @img_binary_data[1].split(',')
    binary_data = Base64.decode64(@img_binary_data[1])
    filename = @user_id.to_s + '.png';
    directory = Rails.public_path.join('user/profile')
    path = File.join(directory, filename)
    @img = File.open(path, 'wb') {|f| f.write(binary_data)}
    if @img
      @user = MstUser.find_by(:id => @user_id)
      @user.trans_user_informations.update(
        :profile_picture => filename,
        )
      flash[:success] = "You have successfully update the profile picture."
    else
      flash[:warning] = "Something went wrong, please try again."
    end
    redirect_to admin_edit_url(:user_id => Base64.encode64(@user_id))
  end

  #change user for default picture
  def update_default_photo
    @user_id = Base64.decode64(params[:user_id])
    @img = params[:p_type]
      @user = MstUser.find_by(:id => @user_id)
      @user.trans_user_informations.update(
        :profile_picture => @img,
        )
    flash[:success] = "You have successfully update the profile picture."
    redirect_to admin_edit_url(:user_id => params[:user_id])
  end


  def destroy
    ifAdminLoggedIn
			@user_id = params[:user_id]
      @admin = MstUser.find_by(:id => Base64.decode64(@user_id))
      if @user_account.role.to_s != "1" and @user_account.id != @admin.id then
        flash[:warning] = "You are not authorize to delete this user."
        redirect_to admin_root_url
      end
					@email_template = MstEmailTemplate.find_by(:email_template_title => 'admin-deleted')
					@subject = @email_template.email_template_subject
					@message = @email_template.email_template_content
					@reserve_words = [
						["||SITE_TITLE||", @site_title],
						["||SITE_PATH||" , admin_root_url],
						["||ADMIN_NAME||" , (@admin.trans_user_informations.first_name) +" "+ (@admin.trans_user_informations.last_name)]
					]
					@reserve_words.each{|words| @message.gsub!(words[0], words[1])}
					@mail_details ={
						:to => @admin.user_email,
						:from => @site_email,
						:subject => @subject,
						:body => @message
					}
					CommonMailer.send_email(@mail_details).deliver_now
					@admin.destroy
			flash[:success] = "User(s) deleted successfully...!"
			redirect_to admin_list_url
	end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'login'
  end
end
