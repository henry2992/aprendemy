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

  # storage :file unless Rails.env == "production"

  def public_id
    # return "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    return "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
end
