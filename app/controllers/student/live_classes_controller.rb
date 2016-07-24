class Student::LiveClassesController < ApplicationController

  before_action :set_data

  def index
  	@live_class = @course.live_class # Revisar para obtener un parámetro o usar otro filtro, verificar cuando se destruyen las clases en vivo
    # @time = Time.parse(@enes.time.to_s).utc.to_i*1000 if @enes
    # flash[:notice] = "No hay clases en vivo programadas"  if !@time
    # redirect_to :back if !@time
    @events = Event.all
    @events_types = EventType.all
  end

  private

  def set_data
    @course = Course.find(params[:course_id])
  end

end
