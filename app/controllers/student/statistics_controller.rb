class Student::StatisticsController < Student::StudentController
  before_filter :check_plan, only: [:index]
  before_action :set_data

  def index
  	
  end

  private

  def set_data
    @course = Course.find(params[:course_id])
  end

end
