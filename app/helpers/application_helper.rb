module ApplicationHelper
	# helper_method :current_user
	#get segment
	def getGlobalData
		@globals = MstSetting.all().order(id: 'asc')
		if session[:user_id].nil? == false then
			@user_account = MstUser.find_by(:id => session[:user_id])
			if @user_account.role != "2" then
				@role = MstRole.find_by(:id => @user_account.role.to_i)
				@role_name = @role.name
			end
		else
			@user_account = []
		end
		@site_title=@globals[0].value
		@site_email=@globals[1].value
		@contact_email=@globals[2].value
		@date_format=@globals[3].value
	end

	def full_title(page_title = '')
		# @globals=MstGlobalSetting.find_by_sql("SELECT tg.*, mg.* from mst_global_settings mg INNER JOIN trans_global_settings tg ON tg.global_name_id=mg.id AND tg.lang_id=17")
		getGlobalData
		@site_title
		base_title = @site_title
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	def segment(segment_no)
		url = request.original_url
		segment = URI(url).path.split('/')[segment_no]
		return segment
	end
	#create seo-friendly URLs
	def seoUrls(name)
		if name and name.nil? == false
			return name.downcase.gsub(" ", "-").parameterize
		else
			return ''
		end
	end
	#
	def convert x
		Float(x)
		i, f = x.to_i, x.to_f
		i == f ? i : f
	rescue ArgumentError
		x
	end
	#credit card number
	def last_digits(number)
	  number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
	end

	def mask(number)
	 "XXXX-XXXX-XXXX-#{last_digits(number)}"
	end
    def current_user
  	    @cr_user = MstUser.find_by(:id => session[:user_id])
		if @cr_user.nil? == false and @cr_user.role != "2" then #2= RegisteredUser
			return "1"
		elsif @cr_user.nil? == false and @cr_user.role == "2" then #2= RegisteredUser
			return "2"
		else
			# if segment(1).to_s == "admin"
			return "0"
				# redirect_to "admin_login_url"
			# else
				# redirect_to "root_url"
			# end
		end
    end

    def current_lang_id
		if session[:lang_code] == "es"
  	  		return "54"
  		else
  			return "17"
  		end
	end
end
