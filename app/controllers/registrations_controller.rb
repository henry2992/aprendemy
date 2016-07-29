class RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_sign_up_params, only: [:create]
  # before_filter :configure_account_update_params, only: [:update]
  skip_before_filter :check_license
  
  protected

    def sign_up_params
      params.require(:user).permit(:first_name, :last_name, :gender, :email, :password, :password_confirmation)
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def account_update_params
      params.require(:user).permit(:first_name, :last_name, :gender, :image, :email, :password, :password_confirmation, :current_password)
    end
end
