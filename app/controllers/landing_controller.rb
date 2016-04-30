class LandingController < ApplicationController

	#Helper Methods to allow device resources to be used in home page
	  helper_method :resource_name, :resource, :devise_mapping


	  def resource_name
		    :user
	  end

	  def resource
	    @resource ||= User.new
	  end

	  def devise_mapping
	    @devise_mapping ||= Devise.mappings[:user]
	 end
	

	def descarga
	end

	def pdf
	    send_file Rails.root.join('app/assets/images', 'enes.pdf'), :type=>"application/pdf", :x_sendfile=>true
	end

	def pagos
	end

end
