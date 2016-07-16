class Student::TestsController < Student::StudentController
  before_action :load_course
  before_action :update_tests_data

  def index
    @course_user = CourseUser.where(course: @course, user: current_user).first if @course
    @tests = Test.all.where.not(id: CourseUserTest.where(course_user: @course_user).map(&:test_id)) if @course_user 
    @course_user_tests = CourseUserTest.where(course_user: @course_user) if @course_user
    # cuts = @course_user_tests
    # cuts.where(status: 0).each { |r| r.status = 1; r.time_left = r.time_left - (Time.now.to_i - r.last_started.to_i); r.last_started = Time.at(Time.now); r.save }
  end
  
  private

    def load_course
      @course = Course.find(params[:course_id])
    end
end
