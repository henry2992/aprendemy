class University < ActiveRecord::Base
	has_many :careers
	
	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :province, :presence => true, :length => { :minimum => 2 }
	validates :city, :presence => true, :length => { :minimum => 2 }
	validates :type, :presence => true
end
