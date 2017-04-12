ActionMailer::DeliveryJob.rescue_from(SparkPostRails::DeliveryException) do |exception|
  Rails.logger.error "/----------- Error enviando Email al Cambiar Password --------------/"
  Rails.logger.error "Archivo: app/mailers/change_password.rb"
  Rails.logger.error "Función: reset_password_instructions"
  Rails.logger.error "Usuario #: "+ user.id
  Rails.logger.error "Email: "+ user.email
  Rails.logger.error "Error: "+ e.message
  return true
end