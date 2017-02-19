class VideoClass < ActiveRecord::Base

	 # Picture Uploader
  	mount_uploader :picture, PictureUploader


	belongs_to :sub_category


end
