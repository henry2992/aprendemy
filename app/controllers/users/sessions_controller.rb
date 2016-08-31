class Users::SessionsController < Devise::SessionsController
  # skip_before_filter :verify_signed_out_user
  # before_filter :configure_sign_in_params, only: [:create]
  def new
    self.resource = resource_class.new(sign_in_params)
    store_location_for(resource, params[:redirect_to])
    super
  end
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    super
    current_user = nil
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end
end
