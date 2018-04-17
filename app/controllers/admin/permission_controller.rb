class Admin::PermissionController < Admin::BaseController
  def list
    ifAdminLoggedIn
    @permissions = MstPermission.all().order(id: 'desc')
  end

  def add
    ifAdminLoggedIn
    @permissions = MstPermission.all().order(id: 'asc')
  end

  def edit
    ifAdminLoggedIn
    @p_id = Base64.decode64(params[:p_id])
    @permission = MstPermission.find_by(:id => @p_id)
    @selected_roles = TransPermissionRole.where(:permission_id => @p_id)
    # render json: @selected_roles
  end
  def update
    ifAdminLoggedIn
    @permission_id = Base64.decode64(params[:p_id])
    @selected_role = params[:privilege][:role_name].reject { |c| c.empty? }
    @old_selected_roles = TransPermissionRole.where(:permission_id => @permission_id)
    @old_selected_roles.each do |sr|
				TransPermissionRole.destroy(sr.id)
			end
    @selected_role.each do |role_id|
			if role_id !=''
			TransPermissionRole.create(
          :permission_id => @permission_id,
					:role_id => role_id
			);
			end
		end
    flash[:success] = "Permission updated successfully."
    redirect_to admin_permission_list_url
  end

  # def update
  #   ifAdminLoggedIn
  #   @permission_id = Base64.decode64(params[:p_id])
  #   @selected_role = params[:privilege][:role_name].reject { |c| c.empty? }
  #   @old_selected_roles = TransPermissionRole.where(:permission_id => @permission_id)
  #   @old_selected_roles.each do |sr|
  #       TransPermissionRole.destroy(sr.id)
  #     end
  #   @selected_role.each do |role_id|
  #     if role_id !=''
  #     TransPermissionRole.create(
  #         :permission_id => @permission_id,
  #         :role_id => role_id
  #     );
  #     end
  #   end
  #   flash[:success] = "Permission updated successfully."
  #   redirect_to admin_permission_list_url
  # end
end
