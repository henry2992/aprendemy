module ApplicationHelper
  def log_in user
    session[:user_id] = user.id
    current_user
  end

  def admin?
    current_user.is_admin? if logged_in?
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def user_is_admin?
    unless admin?
      flash[:danger] = "You do not have access to the Admin page"
      redirect_to root_path
    end
  end

end
