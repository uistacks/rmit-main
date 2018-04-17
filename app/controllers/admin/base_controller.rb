class Admin::BaseController < ApplicationController
  require 'base64'
  require 'uri'
  layout 'admin'
  protected
  #
  def ifAdminLoggedIn
    if current_user.to_s == "0" then
        flash[:warning] = "Please login before proceeding."
        redirect_to admin_login_url
    elsif current_user.to_s == "2" then
      flash[:warning] = "Un authorized admin."
      session[:user_id] = nil
      session[:user_name] = nil
      session[:user_email] = nil
      session[:role] = nil
      session[:first_name] = nil
      session[:user_type] = nil
      redirect_to root_url
    else
      getGlobalData
      if @user_account.trans_user_informations.user_status.to_s == "0"
        flash[:error] = "Your account is not activated yet."
        redirect_to admin_logout_url
      elsif @user_account.trans_user_informations.user_status.to_s == "2"
        flash[:error] = "Your account has been banned, please contact to administrator."
        redirect_to admin_logout_url
      end
      if @user_account.role.to_s != "1" then
        @arr_permissions = TransPermissionRole.select(:permission_id).where(:role_id => @user_account.role.to_i)
        if segment(2).to_s == "role"
          @current_permission = 1
        elsif segment(2).to_s == "user"
          @current_permission = 2
        elsif segment(2).to_s == "content-page"
          @current_permission = 3
        elsif segment(2).to_s == "email-template"
          @current_permission = 4
        elsif segment(2).to_s == "category"
          @current_permission = 5
        elsif segment(2).to_s == "faq"
          @current_permission = 6
        elsif segment(2).to_s == "blog-post"
          @current_permission = 7
        elsif segment(2).to_s == "newsletter"
          @current_permission = 8
        elsif segment(2).to_s == "product"
          @current_permission = 9
        elsif segment(2).to_s == "partner"
          @current_permission = 10
        elsif segment(2).to_s == "how-it-works"
          @current_permission = 11
        elsif segment(2).to_s == "quiz"
          @current_permission = 12 
        elsif segment(2).to_s == "order"
          @current_permission = 13         
        elsif segment(2).to_s == "transaction"
          @current_permission = 14         
        elsif segment(2).to_s == "contactus"
          @current_permission = 15  
        end
        if @arr_permissions.map{|a| a.permission_id}.include? @current_permission
          # render json: "Found";
        else
          if segment(2).to_s != "" and segment(2).to_s != "admin-list" and segment(2).to_s != "index"  and segment(2).to_s != "admin-edit" and segment(2).to_s != "admin-show" and segment(2).to_s != "admin-destroy" and segment(2).to_s != "admin-password-update" and segment(2).to_s != "admin-update"
            # render json: segment(2).to_s;
            flash[:warning] = "You are not authorize to access this page."
            redirect_to admin_root_url
          else
          end
        end
      end
    end
  end

end
