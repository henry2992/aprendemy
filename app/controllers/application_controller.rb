class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :reset_session
  before_filter :set_current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404

  before_filter :set_cache_headers


  include ApplicationHelper, AnsweredQuestionsHelper

  def raise_not_found!
    raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
  end
  
  def render_404
     render :file => "public/404.html", :status => 404
  end

  def render_js_only
    respond_to do |format|
      format.js
      format.html { redirect_to "#{root_path}##{params[:action]}"}
    end
  end

  def after_sign_in_path_for(resource)
    session.delete(:return_to) ||  request.env['omniauth.origin'] || stored_location_for(resource) || user_root_path
  end

  def set_current_user
    User.current = current_user
  end

  private

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
