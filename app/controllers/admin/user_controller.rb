class Admin::UserController < Admin::BaseController

  def list
    ifAdminLoggedIn
    @user_type = params[:type]
    # @user = MstUser.where(:role => "2").order(id: 'asc')
    @user = TransUserInformation
    .select("trans_user_informations.*,u.user_email,u.role")
    .joins("JOIN mst_users as u on u.id=trans_user_informations.user_id")
    .where("u.role" => "2", :user_type=> @user_type.to_s).order(id: 'desc')
    # @user_info = @user.trans_user_informations
    # render json: @user
        case @user_type.to_s
        when "2"
          @page_title = "Customer"
        when "3"
          @page_title = "Promoter"
        when "4"
          @page_title = "Insurance Company"
        end
  end

  def new
    ifAdminLoggedIn
    @user_type = params[:type]
    case @user_type.to_s
        when "2"
          @page_title = "Customer"
        when "3"
          @page_title = "Promoter"
        when "4"
          @page_title = "Insurance Company"
        end
  end

  def create
    ifAdminLoggedIn
    @user_type = params[:user][:user_type]
    # if @user_type == "2" or @user_type == "3"
      # @user_pass = SecureRandom.hex(3)
      @password = Base64.encode64(params[:user][:password])
      @email_id = params[:user][:user_email]
      @email_address=@email_id.split('@')
      @my_username=@email_address[0];
      @user = MstUser.create(
      :user_email => @email_id,
      :role => "2", #Normal User
      :user_password => @password,
      );

      @user_information = TransUserInformation.create(
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :user_status => params[:user][:user_status],
      :user_type => params[:user][:user_type], #RegisteredUser
      :activation_code => Time.now,
      :user_id => @user.id,
      :promoter_commision => params[:user][:commision],
      :promocode_privacy => params[:user][:promocode_privacy]
      );

      @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-registration-successful')
      @subject = @email_template.email_template_subject
      @message = @email_template.email_template_content
      @activation_code= @user_information[:activation_code]
      @user_signin = '<a href="'+ ( user_login_url ) +'">HERE</a>'
      @reserve_words = [
        ["||SITE_TITLE||", @site_title],
        ["||SITE_PATH||" , root_url],
        ["||USER_NAME||" , params[:user][:first_name]],
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
      CommonMailer.send_email(@mail_details).deliver_now
    # else
      # @password = Base64.encode64(params[:user][:password])
      
    # end
    flash[:success]= "Record Added successfully....!"
    redirect_to admin_user_list_url(:type => params[:user][:user_type])
  end

  def edit
    ifAdminLoggedIn
    @user_type = params[:type]
    @user_id = Base64.decode64(params[:user_id])
    @user = MstUser.find_by(:id => Base64.decode64(params[:user_id]))
    @user = TransUserInformation
    .select("trans_user_informations.*,u.*")
    .joins("INNER JOIN mst_users as u on u.id = trans_user_informations.user_id")
    .find_by(:user_id => Base64.decode64(params[:user_id]))

        case @user_type.to_s
        when "2"
          @page_title = "Customer"
        when "3"
          @page_title = "Promoter"
        when "4"
          @page_title = "Insurance Company"
        end
    # render json: @user
  end

  def update
    ifAdminLoggedIn
    @user_type = params[:type]
    @user = MstUser.find_by(:id => params[:edit_user][:edit_id])
    if @user.nil?
      flash[:error]="Record not found....!"
      redirect_to user_url
    else
      @user.update(
      :user_email => params[:edit_user][:user_email]
      )
      @user.trans_user_informations.update(
      :user_name => params[:edit_user][:username],
      :first_name => params[:edit_user][:first_name],
      :last_name => params[:edit_user][:last_name],
      :user_status => params[:edit_user][:user_status],
      :promoter_commision => params[:edit_user][:commision],
      :promocode_privacy => (params[:edit_user][:promocode_privacy].blank? == false) ? params[:edit_user][:promocode_privacy] : "0" 
      )
      if params[:edit_user][:user_email] != params[:edit_user][:old_user_email]
        @activation_code=(Time.now).to_i
        @user.trans_user_informations.update(
        :activation_code => @activation_code,
        :user_status => 0
        );
        @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-updated')
        @subject = @email_template.email_template_subject
        @message = @email_template.email_template_content
        @activation_link = '<a href="'+ (user_account_activate_url(:activation_code => Base64.encode64(@activation_code.to_s)) ) +'">Activate Account</a>'
        @reserve_words = [
          ["||SITE_TITLE||", @site_title],
          ["||SITE_PATH||" , root_url],
          ["||USER_NAME||" , params[:edit_user][:name]],
          ["||USER_EMAIL||", params[:edit_user][:user_email]],
          ["||PASSWORD||" , @pass.to_s],
          ["||USER_ACTIVATION_LINK||" , @activation_link]
        ]
        @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
        @mail_details = {
          :to => params[:edit_user][:user_email],
          :from => @site_email,
          :subject => @subject,
          :body => @message
        }
        CommonMailer.send_email(@mail_details).deliver_now
      end
      flash[:success]="Record Updated successfully....!"
      redirect_to admin_user_list_url(:type => @user_type)
    end
  end
  def update_password
    ifAdminLoggedIn
    @user_type = params[:type]
    @admin = MstUser.find_by(:id => params[:user_pass][:edit_id])
    if @admin.nil?
      flash[:error]="Record not found....!"
      redirect_to admin_list_url
    else
      @admin.update(
      :user_password => Base64.encode64(params[:user_pass][:password])
      )
      flash[:success]="Password Updated successfully....!"
      redirect_to admin_user_list_url(:type => @user_type)
    end
  end
  def show
    ifAdminLoggedIn
    @user_type = params[:type]
    # @admin = MstUser.find_by(:id => Base64.decode64(params[:user_id]))
    @admin = TransUserInformation
    .select("trans_user_informations.*,u.*")
    .joins("INNER JOIN mst_users as u on u.id=trans_user_informations.user_id")
    .find_by(:user_id => Base64.decode64(params[:user_id]))
    case @user_type.to_s
        when "2"
          @page_title = "Customer"
        when "3"
          @page_title = "Promoter"
        when "4"
          @page_title = "Insurance Company"
    end
    # render json: @admin
  end

  def check_email
    if params[:user][:user_email] == params[:user][:old_user_email]
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      @user = MstUser.find_by(:user_email => params[:user][:user_email])
      respond_to do |format|
        format.json { render :json => !@user }
      end
    end
  end

  def change_status
    ifAdminLoggedIn
    if params[:user_id] != ""
      @user = MstUser.find_by(:id => params[:user_id])
      if @user.nil? == false
        if params[:user_status].to_s == "1"
          @email_verified = "1"
        else
          @email_verified = "0"
        end
        @user.trans_user_informations.update(:user_status => params[:user_status].to_i);
        flash[:success] = "Status Updated successfully...!"
        respond_to do |format|
          format.json { render :json => {"error" => "0", "error_message" => "Status changed successfully"} }
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

  def check_user_name
    if params[:user][:username] == params[:user][:old_user_name]
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      @user = TransUserInformation.find_by(:user_name => params[:user][:username])
      respond_to do |format|
        format.json { render :json => !@user }
      end
    end
  end

  #check update
  def check_edit_email
    if params[:edit_user][:user_email] == params[:edit_user][:old_user_email]
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      @user = MstUser.find_by(:user_email => params[:edit_user][:user_email])
      respond_to do |format|
        format.json { render :json => !@user }
      end
    end
  end
  #check
  def check_edit_username
    if params[:edit_user][:username] == params[:edit_user][:old_user_name]
      respond_to do |format|
        format.json { render :json => 'true' }
      end
    else
      @user = TransUserInformation.find_by(:user_name => params[:edit_user][:username])
      respond_to do |format|
        format.json { render :json => !@user }
      end
    end
  end

  #change user picture
  def update_photo
    # @user_id = params[:user_id]
    @user_type = params[:type]
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
    redirect_to admin_user_edit_url(:user_id => Base64.encode64(@user_id),:type => @user_type)
  end

  #change user for default picture
  def update_default_photo
     @user_type = params[:type]
    @user_id = Base64.decode64(params[:user_id])
    @img = params[:p_type]
      @user = MstUser.find_by(:id => @user_id)
      @user.trans_user_informations.update(
        :profile_picture => @img,
        )
    flash[:success] = "You have successfully update the profile picture."
    redirect_to admin_user_edit_url(:user_id => params[:user_id], :type => @user_type)
  end
  
  def destroy
    ifAdminLoggedIn
    @user_type = params[:type]
    @user_id = params[:user_id]
    @user = MstUser.find_by(:id => Base64.decode64(@user_id))
    @user_info = TransUserInformation.find_by(:user_id => Base64.decode64(@user_id))
    @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-deleted')
    @subject = @email_template.email_template_subject
    @message = @email_template.email_template_content
    @reserve_words = [
      ["||SITE_TITLE||", @site_title],
      ["||SITE_PATH||" , root_url],
      ["||USER_NAME||" , (@user.trans_user_informations.first_name)]
    ]
    @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
    @mail_details ={
      :to => @user.user_email,
      :from => @site_email,
      :subject => @subject,
      :body => @message
    }
    CommonMailer.send_email(@mail_details).deliver_now

    MstOrder.where(:email_address => @user.user_email).destroy_all
    @user_info.destroy

    @payment_to = TransUserPaymentHistory.where(:to_id => @user.user_email.to_s)
    if @payment_to.blank? == false
      @payment_to.each do |p|
        p.destroy
      end
    end
    @from_payment = TransUserPaymentHistory.where(:from_id => @user.user_email.to_s)
    if @from_payment.blank? == false
      @from_payment.each do |p|
        p.destroy
      end
    end

    @credit = MstUserCredit.where(:to_user => @user.user_email.to_s)
    if @credit.blank? == false
      @credit.each do |c|
        c.destroy
      end
    end

    @user.destroy

    flash[:success] = "User deleted successfully...!"
    redirect_to admin_user_list_url(:type => @user_type)
  end

  def promoter_credit_list
    ifAdminLoggedIn
    @user_type = params[:type]
    @credit_list = MstUserCredit.where(:to_user => Base64.decode64(params[:user_email]))
    # render json: @credit_list
  end  
end
