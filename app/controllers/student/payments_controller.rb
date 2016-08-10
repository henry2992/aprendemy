class Student::PaymentsController < Student::StudentController
  
  before_action :set_data

  def index  
  end


  private

    # Use callbacks to share common setup or constraints between actions.
     def set_data
      @course = Course.find(params[:course_id])
    end
end
