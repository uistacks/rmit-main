class Admin::BaseController < ApplicationController
  require 'base64'
  require 'uri'
  layout 'admin'
  before_filter :restrict_user_by_role

  # edit valid roles here
  VALID_ROLES = ['super_admin', 'admin']

  protected

  # redirect if user not logged in or does not have a valid role
  def restrict_user_by_role
    unless current_user or VALID_ROLES.include?(current_user.role)
      redirect_to root_url # change this to your 404 page if needed
    end
  end

end
