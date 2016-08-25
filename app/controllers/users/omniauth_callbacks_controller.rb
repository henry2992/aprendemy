class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    # render json: { value: "data data" }
    # Implementaremos este método en nuestro modelo más adelante
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user # this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      return redirect_to student_courses_path
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except('extra')
      redirect_to new_user_registration_url
    end

  end

  def failure
    # render json: { value: request.env["omniauth.auth"] }
    redirect_to root_path
  end
end
