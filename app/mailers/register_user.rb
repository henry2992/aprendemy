class RegisterUser < ApplicationMailer
  def send_mail (user)
    
    sub_data = { 
                  first_name: user.first_name, 
                  last_name: user.last_name, 
                }
    data = {
    #   track_opens: true,
    #   track_clicks: false,
    #   campaign_id: "My Campaign",
    #   transactional: true,
    #   ip_pool = "SPECIAL_POOL",
    #   api_key = "MESSAGE_SPECIFIC_API_KEY"
    #   subaccount = "123"
      substitution_data: sub_data, 
      template_id: "register"
    }
    mail(to: user.email, subject: "Bienvenido al Aprendemy.com", body: "", sparkpost_data: data)
  # rescue => e
  #   Rails.logger.error "/----------- Error enviando Email al registrar usuario --------------/"
  #   Rails.logger.error "Archivo: app/mailers/register_user.rb"
  #   Rails.logger.error "Función: send_mail"
  #   Rails.logger.error "Usuario #: "+ user.id
  #   Rails.logger.error "Email: "+ user.email
  #   Rails.logger.error "Error: "+ e.message
  end
end
