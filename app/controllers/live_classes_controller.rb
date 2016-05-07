class LiveClassesController < ApplicationController
  
  def index
  	@enes = LiveClass.find_by_id(1) # Revisar para obtener un parámetro o usar otro filtro, verificar cuando se destruyen las clases en vivo
    @time = Time.parse(@enes.time.to_s).utc.to_i*1000 if @enes
    flash[:notice] = "There is any live class programmed"  if !@time
    redirect_to :back if !@time
  end
end
