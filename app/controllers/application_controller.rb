class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :check_license

  include ApplicationHelper, AnsweredQuestionsHelper

  def render_js_only
    respond_to do |format|
      format.js
      format.html { redirect_to "#{root_path}##{params[:action]}"}
    end
  end

  def check_license
    if current_user && !(params[:action] == 'payments')
      user_license = current_user.license
      unless current_user.admin? || user_license.premium?
        calculate_license_countdown(user_license) if user_license.free?
        redirect_to payments_path if user_license.expired?
      end
    end
  end

  def calculate_license_countdown license
    days_left = License.plans[:free] - ((Time.now - current_user.created_at).to_i / 1.day)
    license.update!(days_left: days_left)
    if license.days_left < 0
      license.update!(days_left: nil, plan: :expired)
    end
  end

end
