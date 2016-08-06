class Student::PaymentsController < Student::StudentController
  
  # before_action :set_course, only: [:index]

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end
end
