class ContactusController < ApplicationController
  def index
    @page_title = "Contact Us"
  end

  def create
  	if params[:contactus][:email_address] 
  		# @userdata = TransUserInformation
  		# 			.joins('inner join mst_users as u on u.id = trans_user_informations.user_id')
  		# 			.select(:user_name,'user_email').find_by("u.user_email" => params[:contactus][:email_address])
		  @userdata = MstUser.find_by(:user_email => params[:contactus][:email_address])  		
      if @userdata.blank? == false
    		@contact = MstContactu.create(
  			:fullname => @userdata.trans_user_informations.user_name,
  			:user_email => @userdata.user_email,
  			:subject => params[:contactus][:subject],
  			:message => params[:contactus][:message],
        :status => "0"
  			)
  	  else
    		@contact = MstContactu.create(
  			:fullname => params[:contactus][:full_name],
  			:user_email => params[:contactus][:email_address],
  			:subject => params[:contactus][:subject],
  			:message => params[:contactus][:message],
        :status => "0"
  			)
  	  end	
      flash[:success] = t("your_message_sent_succesfully")
    else
      flash[:success] = t("something_went_wrong_try_again")
    end  
  	redirect_to contactus_url
  end	
end
