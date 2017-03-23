class VideoClass < ActiveRecord::Base

	# Picture Uploader
  mount_uploader :picture, PictureUploader if Rails.env == "production"
  mount_uploader :picture, PicUploader unless Rails.env == "production"

	belongs_to :sub_category

end
