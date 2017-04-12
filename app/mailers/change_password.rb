class ChangePassword < Devise::Mailer
  include Rails.application.routes.url_helpers
  include ActionView::Helpers::UrlHelper

  def reset_password_instructions (user,token, opts={})
    @resource = user
    @token = token
    sub_data = { 
                  email: @resource.email,
                  first_name: @resource.first_name, 
                  last_name: @resource.last_name, 
                  url: edit_user_password_url(@resource, reset_password_token: @token)
                }
    data = {
      substitution_data: sub_data, 
      template_id: "change-password"
    }
    mail(to: @resource.email, subject: "Hola #{@resource.first_name}, puedes cambiar tu clave", body: "", sparkpost_data: data)
  rescue Exception => e
    Rails.logger.error "/----------- Error enviando Email al Cambiar Password --------------/"
    Rails.logger.error "Archivo: app/mailers/change_password.rb"
    Rails.logger.error "Función: reset_password_instructions"
    Rails.logger.error "Usuario #: "+ user.id
    Rails.logger.error "Email: "+ user.email
    Rails.logger.error "Error: "+ e.message
    return true
  end
end
