# require "application_responder"

class ApplicationController < ActionController::Base
  # self.responder = ApplicationResponder
  # respond_to :html

  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_filter :set_no_cache, :ifUserLoggedIn
  private

  def ifUserLoggedIn
    if session[:user_id].nil? ==  false
      @logged_user = MstUser.find_by(:id => session[:user_id])
      if @logged_user.blank? == true
        session[:user_id] = nil
        session[:user_name] = nil
        session[:user_email] = nil
        session[:first_name] = nil
        session[:user_type] = nil
        redirect_to root_url
      end
    end
  end
  def set_no_cache
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  before_action :set_locale

def set_locale
    expires_in 10.hours, :public => true
  	if cookies[:educator_locale] && I18n.available_locales.include?(cookies[:educator_locale].to_sym)
  		l = cookies[:educator_locale].to_sym
  	else
  		l = I18n.default_locale
  		cookies.permanent[:educator_locale] = l
  	end
  	I18n.locale = l
  end

  def authenticate
    redirect_to logout_url if session[:user_id].nil?
  end
end
