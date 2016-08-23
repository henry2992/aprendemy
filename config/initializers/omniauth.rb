Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, 
          ENV["FACEBOOK_APP_ID"],
          ENV["FACEBOOK_APP_SECRET"],
          scope: 'email, public_profile', 
          info_fields: 'email, first_name, last_name, gender', 
          :image_size => 'large'
end