class LiveClass < ActiveRecord::Base

	belongs_to :course



	validates :subject, :presence => true, :length => { :minimum => 2 }
	validates :professor, :presence => true, :length => { :minimum => 2 }
	validates :url, :presence => true, :length => { :minimum => 2 }
	validates :time, :presence => true
	validates :explanation, :presence => true, :length => { :minimum => 2 }
	validates :course, :presence => true

end
