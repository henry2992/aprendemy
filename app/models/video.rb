class Video < ActiveRecord::Base

	has_one :resource, as: :material
  	accepts_nested_attributes_for :resource

	validates :name, :presence => true, :length => { :minimum => 2 }
	validates :description, :presence => true, :length => { :minimum => 2 }
	validates :url, :presence => true, format: { with: URI.regexp }
end
