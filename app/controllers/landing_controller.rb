class LandingController < ApplicationController

	before_filter :authenticate_user!
	

	def descarga
		
	end

	def pdf
	    send_file Rails.root.join('app/assets/images', 'enes.pdf'), :type=>"application/pdf", :x_sendfile=>true
	end
end
