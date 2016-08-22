class HomeController < ApplicationController
  
  layout "frontend"

  # Helper Methods to allow device resources to be used in home page
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
	    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def index
    raise Rails.application.secrets.facebook_secret.to_yaml

    if user_signed_in?
      redirect_to student_courses_path if !admin?
      redirect_to student_courses_path if admin?
    end
  end

end
