class Student::LiveClassesController < Student::StudentController

  before_action :set_data

  def index
  	@live_class = @course.live_class # Revisar para obtener un parámetro o usar otro filtro, verificar cuando se destruyen las clases en vivo
    # flash[:notice] = "No hay clases en vivo programadas"  if !@live_class
    @events = Event.all
    @events_types = EventType.all
  end

  private

  def set_data
    @course = Course.find(params[:course_id])
  end

end
