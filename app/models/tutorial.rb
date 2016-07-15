class Tutorial < ActiveRecord::Base

  	validates :title, :description, presence: true
end
