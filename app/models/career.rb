class Career < ActiveRecord::Base

	belongs_to :school
	belongs_to :university

	enum type: ["Tercer Nivel","Tecnología"] unless defined? Career

	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :faculty, :presence => true, :length => { :minimum => 2 }
	validates :type, :presence => true

	validates :school, :presence => true
	validates :university, :presence => true

	self.inheritance_column = :_type_disabled
end
