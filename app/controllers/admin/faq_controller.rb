class Admin::FaqController < Admin::BaseController

  def list
  	ifAdminLoggedIn
  	@faqs = MstFaq.where(:lang_id => 17).order(id: 'desc')
  	# render json: @faqs
  end

  def add
  	ifAdminLoggedIn
  end

  def create
  	ifAdminLoggedIn
  	if params[:faq][:question] != ""
  		@faq = MstFaq.create(
  			:question => params[:faq][:question],
  			:answer => params[:faq][:answer],
  			:slug => seoUrls(params[:faq][:question]),
  			:status => "0",
  			:lang_id => params[:faq][:lang_id]
  			)
  		flash[:success] = "FAQ add successfully"
  		redirect_to admin_faq_list_url
  	end	
  end

  def change_status
  	ifAdminLoggedIn
  	if params[:faq_id] != ""
  		@faq = MstFaq.find_by(:id => params[:faq_id])
  		if @faq.nil? == false   
       @faq.update(:status => params[:status].to_s)
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

  def edit
  	ifAdminLoggedIn
  		@faq = MstFaq.find_by(:id => Base64.decode64(params[:faq_id]))
  end	

  def update
  	ifAdminLoggedIn
  		@faq = MstFaq.find_by(:id => Base64.decode64(params[:faq_id]))
  		@faq.update(
  			:question => params[:update_faq][:question],
  			:slug => seoUrls(params[:update_faq][:question]),
  			:answer => params[:update_faq][:answer],
  			:status => params[:update_faq][:status],
        :lang_id => 17
  			)
  		flash[:success] = "Record update successfully"
  		redirect_to admin_faq_list_url
  end

  def edit_multi
  	ifAdminLoggedIn
  		@faq = MstFaq.find_by(:slug => Base64.decode64(params[:slug]), :lang_id => 12)
  		if @faq.blank? == true
  			@faq = MstFaq.find_by(:slug => Base64.decode64(params[:slug]))
  		end	
  end	

  def update_multi
  	ifAdminLoggedIn
  		@faq = MstFaq.find_by(:slug => Base64.decode64(params[:slug]),:lang_id => 12)
  		if @faq.blank? == true
  			@faq = MstFaq.create(
  			:question => params[:update_faq][:question],
  			:answer => params[:update_faq][:answer],
  			:slug => seoUrls(params[:update_faq][:slug]),
  			:status => "0",
  			:lang_id => 12
  			)
  			flash[:success] = "FAQ add successfully"
  			redirect_to admin_faq_list_url
  		else
	  		@faq.update(
	  			:question => params[:update_faq][:question],
	  			:answer => params[:update_faq][:answer],
	  			:status => params[:update_faq][:status],
	  			:lang_id => 12
	  			)
	  		flash[:success] = "Record update successfully"
	  		redirect_to admin_faq_list_url
	  	end	
  end

  def destroy
    ifAdminLoggedIn
    @faq_id = params[:faq_id]
    if @faq_id.nil? == false
      @faq = MstFaq.find_by(:id => Base64.decode64(@faq_id))
      if @faq.nil? == false
        @faq.destroy
        flash[:success] = "FAQ deleted successfully"
      else
        flash[:success] = "Record not found"
      end
      redirect_to admin_faq_list_url
    end 
  end 
end
