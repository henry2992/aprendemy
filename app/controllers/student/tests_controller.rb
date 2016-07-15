class Student::TestsController < ApplicationController
  before_filter :authenticate_user!
  before_action :load_course

  def index
    @course_user = CourseUser.where(course: @course, user: current_user).first if @course
    @tests = Test.all.where.not(id: CourseUserTest.where(course_user: @course_user).map(&:test_id)) if @course_user 
    @course_user_tests = CourseUserTest.where(course_user: @course_user) if @course_user
  end
  
  private

    def load_course
      @course = Course.find(params[:course_id])
    end
end
