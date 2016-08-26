class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    puts request.env["omniauth.auth"]
    # Implementaremos este método en nuestro modelo más adelante
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      # render json: { value: request.env["omniauth.auth"] }
      sign_in_and_redirect @user #, :event => :authentication
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"].except('extra')
      redirect_to new_user_registration_url
    end

  end

  def failure
    redirect_to root_path
  end
end
