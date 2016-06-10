class Student::CourseTestUserController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_init_sources, only: [:new]
  before_action :set_course_test_user, only: [:show, :edit, :update]

  def new
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@course_user.course.name}", student_course_path(@course_user.course)
    @course_test_user = CourseTestUser.new(course_user: @course_user, test: @test) if ( @test && @course_user )
  end

  def create
    # validar que el usuario haya respondido por lo menos el 75% de todas las preguntas del test
    # validar el tiempo del test
  end

  def edit
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@course_user.course.name}", student_course_path(@course_user.course)
    @course_test_user = CourseTestUser.find(params[:id])
  end

  def update
    # validar que el usuario haya respondido por lo menos el 75% de todas las preguntas del test
    # validar el tiempo del test
  end

  # def destroy
  # end

  private

    def set_init_sources
      course = Course.find(params[:id])
      @test = Test.find(params[:test_id])
      @course_user = CourseUser.where(course: course, user: current_user).first if course
    end

    def set_course_test_user
      @course_test_user = CourseTestUser.find(params[:id])
    end

  #   def course_test_user_params
  #     params.require(:course_test_user).permit(:course_user_id, :test_id)
  #   end
end
