class Admin::SettingController < Admin::BaseController
	def list
		ifAdminLoggedIn
		@global_settings = MstSetting.all().order(id: 'desc')
	end

	def edit
		ifAdminLoggedIn
		@admin = MstUser.find_by(:id => session[:user_id])
		@admin_info = @admin.trans_user_informations
		# if @admin.role_id != 1
		# 	flash[:error]="You don't have privileges to manage Global Settings"
		# 	redirect_to admin_dashboard_url
		# end
		@global_id = Base64.decode64(params[:global_id])
		@global_settings = MstSetting.find_by(:id => @global_id)
		if @global_settings.nil?
			flash[:error] = "Invalid global setting parameter, Please choose valid one"
			redirect_to global_settings_url
		end
		# render json: @global_settings
	end
	def update
		ifAdminLoggedIn
		@admin = MstUser.find(session[:user_id])
		@global_id = Base64.decode64(params[:global_id])
		@global_settings = MstSetting.find_by(:id => @global_id)
		if @global_settings.nil?
			flash[:error] = "Invalid global setting parameter, Please choose valid one"
			redirect_to admin_global_setting_list_url
		else
			if params[:global_settings][:promoter_homepage_video]
					if @global_settings.value.blank? == false
						@vdo_to_delete = "public/videos/"+(@global_settings.value)
				        if File.exist?(@vdo_to_delete)
				        	File.delete(@vdo_to_delete)
				        end
			    	end
				file_video = params[:global_settings][:promoter_homepage_video];
	          	@video = MstSetting.upload_video(params[:global_settings][:promoter_homepage_video])
	          	@global_settings.update(:value => @video,:lang_id => "17")
	        elsif  params[:global_settings][:site_logo]
	        	if @global_settings.value.blank? == false
	          		@img_to_delete = "public/partner_logo/"+(@global_settings.value)
			        if File.exist?(@img_to_delete)
			        	File.delete(@img_to_delete)
			        end
			    end    
				file_img = params[:global_settings][:site_logo];
	          	@site_logo = MstSetting.upload_image(params[:global_settings][:site_logo])
	          	@global_settings.update(:value => @site_logo,:lang_id => "17")
			else
				@global_settings.update(:value => params[:global_settings][:value],:lang_id => "17")
			end
			flash[:success] = "Record updated successfully...!"
			redirect_to admin_global_setting_list_url
		end
	end
end
