class Student::TestsController < Student::StudentController
  before_action :load_course
  before_action :update_tests_data

  def index
    @course_user = CourseUser.where(course: @course, user: current_user).first if @course
    # @tests = Test.all
    @tests = Test.all.where.not(id: CourseUserTest.where(course_user: @course_user).map(&:test_id)).order(:id) if @course_user
    @course_user_tests = CourseUserTest.where(course_user: @course_user) if @course_user
  end
  
  private

    def load_course
      @course = Course.find(params[:course_id])
    end
end
