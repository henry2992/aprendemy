class Student::ProgressController < Student::StudentController
  
  before_action :set_data
  before_filter :check_plan, only: [:index]
  
  # GET /progress
  # GET /progress.json
  def index
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@course_user.course.name} ", student_course_path(@course_user.course)
  end

  private
    
    def set_data
      @course_user = CourseUser.where(course_id: params[:course_id], user: current_user).first
      @progress = @course_user.progress_percent
      @course = Course.find(params[:course_id])
    end
    
end
