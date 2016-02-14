
config = Rails.configuration.database_configuration
host = config[Rails.env]["host"]
db_name = config[Rails.env]["database"]
username = config[Rails.env]["username"]
password = config[Rails.env]["password"]
user_credentials = "#{username}:#{password}@" if username

ENV["QC_DATABASE_URL"] = "postgres://#{user_credentials}localhost/#{db_name}"

# specially for heroku
ENV["DATABASE_URL"] = "postgres://#{user_credentials}localhost/#{db_name}"
