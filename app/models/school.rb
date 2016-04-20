class School < ActiveRecord::Base
	has_many :careers

	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :description, :presence => true, :length => { :minimum => 2 }

	mount_uploader :image, UserUploader
	
	self.inheritance_column = :_type_disabled
end
