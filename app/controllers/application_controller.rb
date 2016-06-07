class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_license
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

  def check_license
    if current_user && !(params[:action] == 'payments')
      user_license = current_user.license
      unless current_user.admin? || user_license.try(:premium?)
        calculate_license_countdown(user_license) if user_license.try(:free?)
        redirect_to payments_path if user_license.try(:expired?)
      end
    end
  end

  def calculate_license_countdown license
    days_left = License.plans[:free] - ((Time.now - current_user.created_at).to_i / 1.day)
    if days_left >= 0
      license.update!(days_left: days_left)
    else
      license.update!(days_left: nil, plan: :expired)
    end
  end

end
