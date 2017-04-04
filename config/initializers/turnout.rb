Turnout.configure do |config|
  config.maintenance_pages_path = config.app_root.join('public').to_s
  config.default_maintenance_page = Turnout::MaintenancePage::HTML
  config.default_reason = '<p>Hacemos nuestro mejor esfuerzo para hacer de tu experiencia en Aprendemy la mejor de internet.</p><p>Muy pronto estaremos online de nuevo.</p>'
end