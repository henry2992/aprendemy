class WebinarController < ApplicationController
  
  def index
  	
  	@webinars = Webinar.all

  	@live_class = LiveClass.find_by_id(1)

  end

end
