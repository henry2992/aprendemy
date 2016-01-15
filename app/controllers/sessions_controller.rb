class SessionsController < Devise::SessionsController
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice,  :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)
    redirect_to root_path
    # if current_user
    # else
      # respond_with resource, :location => root_path(resource_name, resource)
    # end
  end
end
