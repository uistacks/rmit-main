class Admin::RoleController < Admin::BaseController
  def list
    ifAdminLoggedIn
    @roles = MstRole.where.not(:name => ['SuperAdmin','RegisteredUser']).order(id: :desc)
  end

  def add
    ifAdminLoggedIn
  end
  def create
    ifAdminLoggedIn
      @roles = MstRole.create(:name => params[:role][:role_name],:description => params[:role][:description]);
			flash[:success] = "Role added successfully...!"
			redirect_to admin_role_list_url
  end

  def edit
    ifAdminLoggedIn
    @role = MstRole.find_by(:id => Base64.decode64(params[:role_id]));
  end
  def update
    ifAdminLoggedIn
    @role = MstRole.find_by(:id => Base64.decode64(params[:role_id]));
			if @role.nil?
				flash[:error] = "Role not found..!"
				redirect_to admin_role_list_url
			else
				@role.update(:name => params[:role][:role_name],:description => params[:role][:description]);
          flash[:success] = "Role updated successfully...!"
  				redirect_to admin_role_list_url
			end
  end

  def check_role
		if params[:role][:type] == "edit"
			if params[:role][:role_name].downcase == params[:role][:old_role_name].downcase
				respond_to do |format|
					format.json { render :json => 'true' }
				end
			else
				@arr_role_detail  = MstRole.find_by(:name => params[:role][:role_name]);
				respond_to do |format|
					format.json { render :json => !@arr_role_detail }
				end
			end
		else
			@arr_role_detail  = MstRole.find_by(:name => params[:role][:role_name]);
			respond_to do |format|
				format.json { render :json => !@arr_role_detail }
			end
		end
	end
  def destroy
    ifAdminLoggedIn
			@role_id = params[:role_id]
      @role = MstRole.find_by(:id => Base64.decode64(@role_id))
      if @role.nil? == false then
			@role.destroy
        flash[:success] = "Role deleted successfully."
      else
        flash[:error] = "Something went wrong, please try again."
      end
			redirect_to admin_role_list_url
	end

	def permission
		ifAdminLoggedIn
		@role = MstRole.find_by(:id => Base64.decode64(params[:role_id]));
		@selected_roles = TransPermissionRole.where(:role_id => Base64.decode64(params[:role_id]))
		# render json: @permissions
	end	

	def update_permission
    ifAdminLoggedIn
    @role_id = Base64.decode64(params[:role_id])
    @selected_role = params[:privilege][:role_name].reject { |c| c.empty? }
    @old_selected_roles = TransPermissionRole.where(:role_id => @role_id)
    # render json: @old_selected_roles
    @old_selected_roles.each do |sr|
				TransPermissionRole.destroy(sr.id)
			end
    @selected_role.each do |per_id|
			if per_id !=''
			TransPermissionRole.create(
            :permission_id => per_id,
			:role_id => @role_id
			);
			end
		end
    flash[:success] = "Permission updated successfully."
    redirect_to admin_role_list_url
  end
end
