class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_current_user
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404
  rescue_from ActionController::RoutingError, :with => :render_404

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
    student_courses_path
  end

  def set_current_user
    User.current = current_user
  end

end
