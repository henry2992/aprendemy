class Student::LiveClassesController < Student::StudentController
  before_filter :check_plan, only: [:index]
  before_action :set_data

  def index
    @categories = Category.all
  end

  private

  def set_data
    @course = Course.find(params[:course_id])
  end

end
