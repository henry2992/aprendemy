# encoding: utf-8

class PictureUploader < CarrierWave::Uploader::Base

 include Cloudinary::CarrierWave
  
  # process :tags => ["photo_album_sample"]
  # process :convert => "jpg"

  # if Rails.env.production?
  #   storage :fog
  # else
  #   storage :file
  # end

 
end
