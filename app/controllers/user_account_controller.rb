class UserAccountController < ApplicationController

  def dashboard
    if session[:user_id].nil? != false
      flash[:warning] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id.to_i)
    end
  end

  def edit_profile
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
      # render json: @userdata.mst_bank_details
      # @bank_details = MstBankDetail.find_by(:user_id_fk => @user_id)
    end
  end

  def update_profile
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      # if params[:upload_pic][:avatar]	
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
      @userdata.trans_user_informations.update(
          :first_name => params[:update_profile][:first_name],
          :last_name => params[:update_profile][:last_name],
          :user_mobile => params[:update_profile][:phone_number],
          :user_address => params[:update_profile][:address],
          # :paypal_acc => params[:update_profile][:paypal_acc],
          :promoter_commision => params[:update_profile][:commision]
      )
      if very_paypal.accountStatus == "VERIFIED" then
        @userdata.trans_user_informations.update(
            :paypal_acc => params[:update_profile][:paypal_acc]
        )
        flash[:success] = t("record_updated_successfully")
        @redirectpath = user_dashboard_url
      else
        @userdata.trans_user_informations.update(
            :paypal_acc => ""
        )
        flash[:warning] = "Your account has been updated successfully, but you need to verify your PayPal email."
        @redirectpath = edit_profile_url(:user_id => Base64.encode64(@user_id))
      end
      @bank_detail = MstBankDetail.find_by(:user_id_fk => @user_id)
      if @bank_detail.blank? == false
        @bank_detail.update(
            :bank_name => params[:update_profile][:bank_name],
            :account_no => params[:update_profile][:acc_no],
            :acc_holder_name => params[:update_profile][:acc_holder_name],
            :ifsc => params[:update_profile][:ifsc_code]
        )
      else
        @bank_info = MstBankDetail.create(
            :bank_name => params[:update_profile][:bank_name],
            :account_no => params[:update_profile][:acc_no],
            :acc_holder_name => params[:update_profile][:acc_holder_name],
            :ifsc => params[:update_profile][:ifsc_code],
            :user_id_fk => @user_id
        )
      end
      # flash[:success] = t("record_updated_successfully")
      redirect_to @redirectpath
    end
  end

  def very_paypal
    require 'paypal-sdk-adaptiveaccounts'
    @api = PayPal::SDK::AdaptiveAccounts::API.new( :device_ipaddress => "127.0.0.1" )

# Build request object
    @get_verified_status = @api.build_get_verified_status({
                                                              :emailAddress => params[:update_profile][:paypal_acc],
                                                              :matchCriteria => "NONE",
                                                              :firstName => params[:update_profile][:first_name],
                                                              :lastName => params[:update_profile][:last_name] })

# Make API call & get response
    @get_verified_status_response = @api.get_verified_status(@get_verified_status)

# Access Response
    if @get_verified_status_response.success?
      @get_verified_status_response.accountStatus
      @get_verified_status_response.countryCode
      @get_verified_status_response.userInfo
    else
      @get_verified_status_response.error
    end
    return @get_verified_status_response
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
      flash[:success] = t("you_have_successfully_update_the_profile_picture")
    else
      flash[:warning] = t("something_went_wrong_please_try_again")
    end
    redirect_to user_dashboard_url
  end

  #change user for default picture
  def update_default_photo
    @user_id = Base64.decode64(params[:user_id])
    @img = params[:p_type]
    @user = MstUser.find_by(:id => @user_id)
    @user.trans_user_informations.update(
        :profile_picture => @img,
    )
    flash[:success] = t("you_have_successfully_update_the_profile_picture")
    redirect_to user_dashboard_url
  end

  def edit_email_address
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
    end
    render 'user_account/account_setting'
  end

  def update_email_address
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      getGlobalData
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
      if params[:update_user_email][:user_email] != params[:update_user_email][:new_user_email]
        @userdata.update(:user_email => params[:update_user_email][:new_user_email])
        @userdata.trans_user_informations.update(:user_status => "0")
      end
      @password = Base64.decode64(@userdata.user_password)
      @email_template = MstEmailTemplate.find_by(:email_template_title => 'user-updated')
      @subject = @email_template.email_template_subject
      @message = @email_template.email_template_content
      @reserve_words = [
          ["||SITE_TITLE||", @site_title],
          ["||USER_NAME||" , @userdata.trans_user_informations.user_name],
          ["||USER_EMAIL||" , params[:update_user_email][:new_user_email]],
          ["||PASSWORD||" , @password]
      ]
      @reserve_words.each{|words| @message.gsub!(words[0], words[1])}
      @mail_details ={
          :to => @userdata.user_email,
          :from => @site_email,
          :subject => @subject,
          :body => @message
      }
      CommonMailer.send_email(@mail_details).deliver_now
    end
    flash[:success] = t("acoount_setting_updated_successfully")
    redirect_to user_logout_url
  end

  def update_password
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
      if params[:update_password][:password] != params[:update_password][:new_password]
        @userdata.update(:user_password => Base64.encode64(params[:update_password][:new_password]))
      end
      flash[:success] = t("acoount_setting_updated_successfully")
      redirect_to user_logout_url
    end
  end

  def charts
    require 'time'
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      getGlobalData
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id.to_i)
      # @trans_promotor_earning = TransPaymentHistory.where(:to_id => @userdata.user_email)
      # @promotor_earning = TransPaymentHistory.where('created_at > ? and created_at < ?', Date.today.beginning_of_month - 3.months, Date.today.beginning_of_month - 2.months).to_sql
      #get last 4 month data
      @trans_promotor_earning = TransUserPaymentHistory
                                    .select(:id, :order_id, :from_id, :to_id, :amount ,:created_at,'mp.title','mp.id as product_id','o.title as order_name')
                                    .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                                    .where(:to_id => @userdata.user_email)
                                    .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at <= ?', Time.now.beginning_of_month - 3.months, Time.now.beginning_of_month + 1.months )
                                    .order('trans_user_payment_histories.created_at desc')

      @arr_employer_count = []
      @arr_year = []
      @arr_month = []
      @cur_year = Time.now.strftime("%Y").to_i;
      @cur_month = Time.now.strftime("%m").to_i;
      @trans_promotor_earning.each do |data|
        @time = Time.parse(data.created_at.to_s);
        @month = @time.strftime("%m").to_i - 1;
        @year = @time.strftime("%Y").to_i;
        if @year == @cur_year
          @new_year = @cur_year
        else
          @new_year = @cur_year.to_i - 1
        end
        @product_id = data.product_id
        @arr_employer_count[@month] = @arr_employer_count[@month].to_f + data.amount.round(2)
        @arr_year[@month] = @new_year
        @arr_month[@month] = @month.to_i + 1;
      end
      @arr_sales_val = @arr_employer_count  - ["", nil]
      @arr_sales_year = @arr_year - ["", nil]
      @arr_sales_month = @arr_month - ["", nil]
      @promotor_earning = @arr_sales_val;
      if @arr_sales_val[0].nil? == false then
        @m1 = @arr_sales_month[0].to_i
        @month_1 = Date::MONTHNAMES[@m1]
        @month1 = @month_1.to_s + '-' + @arr_sales_year[0].to_s
        if @arr_sales_month[0] == @cur_month then
          @time_now1 = Time.now.beginning_of_month
          @time_now_end1 = Time.now.end_of_month
        else
          @time_now1 = Time.now.beginning_of_month - 1.months
          @time_now_end1 = Time.now.beginning_of_month
        end
        @month1_bupa = TransUserPaymentHistory
                           .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                           .where(:to_id => @userdata.user_email).where("mp.title like ?","%Bupa OSHC%")
                           .where( 'trans_user_payment_histories.created_at > ? AND trans_user_payment_histories.created_at < ?',@time_now1, @time_now_end1)
                           .sum('trans_user_payment_histories.amount')
        @month1_nib = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%nib%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now1, @time_now_end1)
                          .sum('trans_user_payment_histories.amount')
        @month1_medibank = TransUserPaymentHistory
                               .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                               .where(:to_id => @userdata.user_email).where("mp.title like ?","%Medibank%")
                               .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now1, @time_now_end1)
                               .sum('trans_user_payment_histories.amount')
        @month1_allianz = TransUserPaymentHistory
                              .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                              .where(:to_id => @userdata.user_email).where("mp.title like ?","%Allianz%")
                              .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now1, @time_now_end1)
                              .sum('trans_user_payment_histories.amount')
        @month1_ahm = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%ahm%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now1, @time_now_end1)
                          .sum('trans_user_payment_histories.amount')
      end
      if @arr_sales_val[1].nil? == false then
        @m2 = @arr_sales_month[1].to_i
        @month_2 = Date::MONTHNAMES[@m2]
        @month2 = @month_2 + '-' + @arr_sales_year[1].to_s
        if @arr_sales_month[1] == @cur_month then
          @time_now2 = Time.now.beginning_of_month
          @time_now_end2 = Time.now.end_of_month
        else
          @time_now2 = Time.now.beginning_of_month - 1.months
          @time_now_end2 = Time.now.beginning_of_month
        end
        @month2_bupa = TransUserPaymentHistory
                           .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                           .where(:to_id => @userdata.user_email).where("mp.title like ?","%Bupa OSHC%")
                           .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now2, @time_now_end2)
                           .sum('trans_user_payment_histories.amount')
        @month2_nib = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%nib%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?',  @time_now2, @time_now_end2)
                          .sum('trans_user_payment_histories.amount')
        @month2_medibank = TransUserPaymentHistory
                               .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                               .where(:to_id => @userdata.user_email).where("mp.title like ?","%Medibank%")
                               .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now2, @time_now_end2)
                               .sum('trans_user_payment_histories.amount')
        @month2_allianz = TransUserPaymentHistory
                              .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                              .where(:to_id => @userdata.user_email).where("mp.title like ?","%Allianz%")
                              .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now2, @time_now_end2)
                              .sum('trans_user_payment_histories.amount')
        @month2_ahm = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%ahm%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now2, @time_now_end2)
                          .sum('trans_user_payment_histories.amount')
      end
      if @arr_sales_val[2].nil? == false then
        @m3 = @arr_sales_month[2].to_i
        @month_3 = Date::MONTHNAMES[@m3]
        @month3 = @month_3 + '-' + @arr_sales_year[2].to_s
        if @arr_sales_month[2] == @cur_month then
          @time_now3 = Time.now.beginning_of_month
          @time_now_end3 = Time.now.end_of_month
        else
          @time_now3 = Time.now.beginning_of_month - 3.months
          @time_now_end3 = Time.now.beginning_of_month - 2.months
        end
        @month3_bupa = TransUserPaymentHistory
                           .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                           .where(:to_id => @userdata.user_email).where("mp.title like ?","%Bupa OSHC%")
                           .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now3, @time_now_end3)
                           .sum('trans_user_payment_histories.amount')
        @month3_nib = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%nib%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now3, @time_now_end3)
                          .sum('trans_user_payment_histories.amount')
        @month3_medibank = TransUserPaymentHistory
                               .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                               .where(:to_id => @userdata.user_email).where("mp.title like ?","%Medibank%")
                               .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now3, @time_now_end3)
                               .sum('trans_user_payment_histories.amount')
        @month3_allianz = TransUserPaymentHistory
                              .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                              .where(:to_id => @userdata.user_email).where("mp.title like ?","%Allianz%")
                              .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now3, @time_now_end3)
                              .sum('trans_user_payment_histories.amount')
        @month3_ahm = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%ahm%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now3, @time_now_end3)
                          .sum('trans_user_payment_histories.amount')
      end
      if @arr_sales_val[3].nil? == false then
        @m4 = @arr_sales_month[3].to_i
        @month_4 = Date::MONTHNAMES[@m4]
        @month4 = @month_4 + '-' + @arr_sales_year[3].to_s
        if @arr_sales_month[3] == @cur_month then
          @time_now4 = Time.now.beginning_of_month
          @time_now_end4 = Time.now.end_of_month
        else
          @time_now4 = Time.now.beginning_of_month - 2.months
          @time_now_end4 = Time.now.beginning_of_month - 1.months
        end
        @month4_bupa = TransUserPaymentHistory
                           .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                           .where(:to_id => @userdata.user_email).where("mp.title like ?","%Bupa OSHC%")
                           .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now4, @time_now_end4)
                           .sum('trans_user_payment_histories.amount')
        @month4_nib = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%nib%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now4, @time_now_end4)
                          .sum('trans_user_payment_histories.amount')
        @month4_medibank = TransUserPaymentHistory
                               .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                               .where(:to_id => @userdata.user_email).where("mp.title like ?","%Medibank%")
                               .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now4, @time_now_end4)
                               .sum('trans_user_payment_histories.amount')
        @month4_allianz = TransUserPaymentHistory
                              .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                              .where(:to_id => @userdata.user_email).where("mp.title like ?","%Allianz%")
                              .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now4, @time_now_end4)
                              .sum('trans_user_payment_histories.amount')
        @month4_ahm = TransUserPaymentHistory
                          .joins('inner join mst_orders as o on o.id = trans_user_payment_histories.order_id inner join mst_products as mp on mp.id = o.product_id')
                          .where(:to_id => @userdata.user_email).where("mp.title like ?","%ahm%")
                          .where('trans_user_payment_histories.created_at > ? and trans_user_payment_histories.created_at < ?', @time_now4, @time_now_end4)
                          .sum('trans_user_payment_histories.amount')
      end
# render json: @month2_bupa
    end
  end
  def cust_become_promoter
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id)
      @lang_id = current_lang_id
      @quiz_question = MstQuiz.where(:status => 1, :lang_id => @lang_id.to_i)
      @que_count = MstQuiz.where(:status => 1, :lang_id => @lang_id.to_i).count()
      @quiz_shuffle = @quiz_question.shuffle
    end
  end
  def save_cust_become_promoter
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = TransUserInformation.find_by(:id => @user_id)
      @activation_code = rand(36**8).to_s(36)
      @intial = @userdata.first_name[0..2]
      @promo_code = @intial.to_s+"-"+@activation_code
      @userdata.update(:user_type => "3", :promo_code =>  @promo_code);
      @ip = request.remote_ip
      MstTempQuiz.where(:ip_address => @ip).destroy_all
      flash[:success] = t("congratulations_are_you_now_become_promoter")
      redirect_to user_logout_url
    end
  end

  def promoter_wallet
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id)
      @my_wallet = MstUserCredit.find_by(:to_user => @userdata.user_email)
    end
  end

  def payment_request
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = Base64.decode64(params[:user_id])
      @userdata = MstUser.find_by(:id => @user_id)
      @request = MstPaymentRequest.create(
          :from_user => @userdata.id.to_s,
          :amount => params[:pay_request][:req_amount],
          :status => "0"
      )
      flash[:success] = t("your_payment_request_sent_successfully")
      redirect_to promoter_wallet_url
    end
  end
  def user_order
    getGlobalData
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id)
      # where("first_name = ? AND last_name = ?", first_name, last_name)
      # @order_list = MstOrder.where(:email_address => @userdata.user_email).order(:id => 'desc')
      @order_list = MstOrder
                        .joins('inner join mst_products as p on p.id = mst_orders.product_id')
                        .select('mst_orders.*','p.title as cmp_name, p.contact_email as cmp_contact_email')
                        .where(:email_address => @userdata.user_email).order(:id => 'desc')
    end
  end
  def order_view
    getGlobalData
    @user_id = session[:user_id]
    @userdata = MstUser.find_by(:id => @user_id)
    @order_id = Base64.decode64(params[:order_id])
    @order = MstOrder
                 .joins('inner join mst_products as p on p.id = mst_orders.product_id inner join trans_user_payment_histories as tp on tp.order_id = mst_orders.id inner join trans_australian_addresses as a on a.order_id = mst_orders.id')
                 .select('mst_orders.*,mst_orders.created_at as order_date','p.*','tp.amount','a.city,a.postal_code,a.state')
                 .find_by(:id => @order_id)
    @defedent_detail = TransPolicyPartnerAndDepender.where(:order_id => @order.id)
    # render json: @order

  end

  def user_transactions
    getGlobalData
    if session[:user_id].nil? != false
      flash[:error] = t("please_login_to_procced")
      redirect_to root_url
    else
      @user_id = session[:user_id]
      @userdata = MstUser.find_by(:id => @user_id)
      @user_email = session[:user_email]
      # @order_list = MstOrder.where(:email_address => @userdata.user_email).order(:id => 'desc')
      @trans_history = TransUserPaymentHistory
                           .joins('LEFT JOIN mst_orders o on o.email_address = trans_user_payment_histories.from_id LEFT JOIN mst_products as p on p.paypal_account = trans_user_payment_histories.to_id')
                           .select('o.email_address as from_useremail, o.name as from_name, p.contact_email as to_email, p.title as to_name', :id, :amount, :transaction_id, :status, :payment_type, :to_id, :created_at)
                           .where("from_id = ? OR to_id = ?", @user_email, @user_email)
                           .group(:id).order(:id => 'desc')
    end
    # render json: @trans_history
  end

end
