class School < ActiveRecord::Base
	has_many :careers

	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :description, :presence => true, :length => { :minimum => 2 }

  mount_uploader :image, PictureUploader if Rails.env == "production"
  mount_uploader :image, PicUploader unless Rails.env == "production"

end
