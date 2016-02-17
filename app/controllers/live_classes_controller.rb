class LiveClassesController < ApplicationController
  
  def index
  	@enes = LiveClass.find_by_id(1)
  	@time = Time.parse(@enes.time.to_s).utc.to_i*1000
  end

end
