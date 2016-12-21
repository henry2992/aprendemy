module ApplicationHelper
  def log_in user
    session[:user_id] = user.id
    current_user
  end

  def admin?
    current_user.admin? if logged_in?
  end

  def psicologist?
    # current_user.psicologist? if logged_in?
    ( current_user.admin? || current_user.psicologist? ) if logged_in?
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def user_is_psicologist?
    return unless !psicologist?
    flash[:danger] = "No tienes acceso a la página que quieres visitar"
    redirect_to root_path
  end

  def user_is_admin?
    # unless admin?
    #   flash[:danger] = "No tienes acceso a la página que quieres visitar"
    #   redirect_to root_path
    # end
    return unless !admin?
    flash[:danger] = "No tienes acceso a la página que quieres visitar"
    redirect_to root_path
  end

end
