class Tutorial < ActiveRecord::Base

  	validates :title, :description, presence: true
  	belongs_to :sub_category
end
