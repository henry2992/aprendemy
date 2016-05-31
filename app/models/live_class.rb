class LiveClass < ActiveRecord::Base

	belongs_to :course

	enum online_now: [:yes, :no] unless defined? LiveClass

	validates :subject, :presence => true, :length => { :minimum => 2 }
	validates :professor, :presence => true, :length => { :minimum => 2 }
	validates :url, :presence => true, :length => { :minimum => 2 }
	validates :online_now, :presence => true
	validates :time, :presence => true
	validates :explanation, :presence => true, :length => { :minimum => 2 }
	validates :course, :presence => true

end
