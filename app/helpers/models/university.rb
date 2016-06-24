class University < ActiveRecord::Base
	has_many :careers
	enum type: ["Universidad","Instituto"]

	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :province, :presence => true, :length => { :minimum => 2 }
	validates :city, :presence => true, :length => { :minimum => 2 }
	validates :type, :presence => true

	mount_uploader :logo, PictureUploader
	self.inheritance_column = :_type_disabled
end
