class Student::CoursesController < Student::StudentController
  
  before_action :set_course, only: [:check_plan, :show]
  before_action :set_course_user, only: [:show]

  before_filter :check_plan, only: [:show]
  
  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @progress = @course_user.progress_percent
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    def set_course_user
      @course_user = course_user
    end

end
