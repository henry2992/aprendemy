class Video < ActiveRecord::Base

	has_one :resource, as: :material
  	accepts_nested_attributes_for :resource

end
