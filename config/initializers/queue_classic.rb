
config = Rails.configuration.database_configuration
host = config[Rails.env]["host"]
db_name = config[Rails.env]["database"]
username = config[Rails.env]["username"]
password = config[Rails.env]["password"]
user_credentials = "#{username}:#{password}@" if username

if Rails.env.production?
  ENV["QC_DATABASE_URL"] = "postgres://postgres:1aprendemy@localhost/aprendemy_production"
  # "postgres://#{user_credentials}localhost/#{db_name}"
else
  ENV["QC_DATABASE_URL"] = ENV["DATABASE_URL"] = "postgres://#{user_credentials}localhost/#{db_name}"
end

# specially for heroku
