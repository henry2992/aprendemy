class Congrats < ApplicationMailer
  def send_mail (course_user)
    
    sub_data = { 
                  first_name: course_user.user.first_name, 
                  last_name: course_user.user.last_name, 
                  course_name: course_user.course.name
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
      template_id: "congrats"
    }
    mail(to: course_user.user.email, subject: "Felicitacionas has completado el curso: #{course_user.course.name}", body: "", sparkpost_data: data)
  # rescue => e
  #   Rails.logger.error "/----------- Error enviando Email al Completar un Curso --------------/"
  #   Rails.logger.error "Archivo: app/mailers/congrats.rb"
  #   Rails.logger.error "Función: send_mail"
  #   Rails.logger.error "Usuario #: "+ course_user.user.id
  #   Rails.logger.error "Email: "+ course_user.user.email
  #   Rails.logger.error "Error: "+ e.message
  end
end
