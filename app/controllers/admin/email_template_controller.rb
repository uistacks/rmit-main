class Admin::EmailTemplateController < Admin::BaseController
	def list
		ifAdminLoggedIn
		@email_template = MstEmailTemplate.where(:lang_id => "17").order(id: 'asc')
	    # render json: @content_pages
	end
	def edit
		ifAdminLoggedIn
		@email_template = MstEmailTemplate.find_by(:id => Base64.decode64(params[:email_id]))     
		if @email_template.nil?
			flash[:error] = "Email template not found...!"
			redirect_to admin_email_template_list_url
		end
	end

	def update
		ifAdminLoggedIn       
		@email_template = MstEmailTemplate.find_by(:id => Base64.decode64(params[:email_id]))
		if @email_template.nil?
			flash[:error] = "Email template not found...!"
			redirect_to admin_email_template_list_url
		else
			@email_template.update(
				:email_template_title => params[:email_template][:title],
				:email_template_subject => params[:email_template][:subject],
				:email_template_content => params[:email_template][:content],
				:active => "1",
				:lang_id => "17"
				)
			flash[:success] = "Email template updated Successfully...!"
			redirect_to admin_email_template_list_url
		end   
	end

	def edit_multilang
		ifAdminLoggedIn
		@email_template = MstEmailTemplate.find_by(:email_template_title => Base64.decode64(params[:temp_title]), :lang_id => "12")     
		if @email_template.nil?
			flash[:error] = "Email template not found...!"
			redirect_to admin_email_template_list_url
		end
	end

	def update_multilang
		ifAdminLoggedIn       
		@email_template = MstEmailTemplate.find_by(:id => Base64.decode64(params[:email_id]), :lang_id => "12")
		# render json: @email_template
		if @email_template.nil?				
			MstEmailTemplate.create(:email_template_title => params[:email_template][:title],:email_template_subject => params[:email_template][:subject], :email_template_content => params[:email_template][:content], :lang_id => "12")
			flash[:success] = "Email template created successfully...!"
			redirect_to admin_email_template_list_url
		else
			@email_template.update(
				:email_template_subject => params[:email_template][:subject],
				:email_template_content => params[:email_template][:content],
				:active => "1",
				:lang_id => "12"
				)
			flash[:success] = "Email template updated Successfully...!"
			redirect_to admin_email_template_list_url
		end		
	end

	def check_title
		if params[:email_template][:title] == params[:email_template][:old_title]
			respond_to do |format|
				format.json { render :json => 'true' }
			end
		else
			@email_template = MstEmailTemplate.find_by(:email_template_title => params[:email_template][:title])
			respond_to do |format|
				format.json { render :json => !@cms }
			end
		end
	end  

end
