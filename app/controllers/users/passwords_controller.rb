class Users::PasswordsController < Devise::PasswordsController
  
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    else
      respond_with(resource)
    end
  rescue SparkPostRails::DeliveryException => e
    u = resource_class.find_by_email(resource_params[:email])
    
    Rails.logger.error "/----------- Error enviando Email al Cambiar Password --------------/"
    Rails.logger.error "Archivo: app/controllers/users/passwords_controller.rb"
    Rails.logger.error "Función: create"
    Rails.logger.error "Usuario #: "+ u.id.to_s
    Rails.logger.error "Email: "+ u.email
    Rails.logger.error "Error: "+ e.message
    respond_with({}, location: after_sending_reset_password_instructions_path_for(resource_name))
    return true
  end

  protected
    def after_resetting_password_path_for(resource)
      signed_in_root_path(resource)
    end
end