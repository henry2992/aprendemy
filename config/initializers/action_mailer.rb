ActionMailer::DeliveryJob.rescue_from(SparkPostRails::DeliveryException) do |exception|
  Rails.logger.error "/----------- Error enviando Email al recordatorio de renovación de plan --------------/"
  Rails.logger.error "Archivo: app/mailers/renew_plan.rb"
  Rails.logger.error "Función: send_mail"
  Rails.logger.error "Usuario #: "+ course_user.user.id
  Rails.logger.error "Email: "+ course_user.user.email
  Rails.logger.error "Error: "+ e.message
end