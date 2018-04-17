class Admin::ContactusController < Admin::BaseController
  def list
  	ifAdminLoggedIn
  	@contactus = MstContactu.all.order('id desc')
  end

  def view
  	ifAdminLoggedIn
  	@contactus = MstContactu.find_by(:id => Base64.decode64(params[:cont_id]))
  end

  def send_contactus
  	ifAdminLoggedIn
  	getGlobalData
  	@contactus = MstContactu.find_by(:id => Base64.decode64(params[:cont_id]))
  	if params[:contactus][:message]
	    @subject = @contactus.subject
	    @message = params[:contactus][:message]
	    @mail_details ={
	      :to => @contactus.user_email,
	      :from => @site_email,
	      :subject => @subject,
	      :body => @message
	    }
	    CommonMailer.send_email(@mail_details).deliver_now
	    if @contactus.status == "0"
	    	@contactus.update(:status => "1");
	    end	
	    flash[:success] = "Replied to "+@contactus.user_email+" successfully"	
  	    redirect_to admin_contactus_list_url
  	end
  end	
  	
  	def destroy
  		ifAdminLoggedIn
  		@contactus = MstContactu.find_by(:id => Base64.decode64(params[:cont_id]))
  		if @contactus.blank? == false
  			@contactus.destroy
  		end	
	    flash[:success] = "Record deleted successfully"	
  	    redirect_to admin_contactus_list_url
  	end	
end
