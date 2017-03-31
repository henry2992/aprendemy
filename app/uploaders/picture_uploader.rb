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
    # public_id
    # return "#{model.short_name}/#{mounted_as}/#{model.id}"
    uniq_id = Digest::MD5.hexdigest("#{Time.now.utc}-#{current_path}-#{rand}")
    file_id = File.basename(original_filename, '.*')
    "#{model.class.to_s.underscore}/#{file_id}-#{uniq_id}"  
  end
  # def store_dir
  #   "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  # end
end
