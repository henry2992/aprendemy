class Student::CourseUserTestsController < ApplicationController
  before_action :set_student_course_user_test, only: [:show, :edit, :update, :destroy]

  # GET /student/course_user_tests
  # GET /student/course_user_tests.json
  def index
    @student_course_user_tests = Student::CourseUserTest.all
  end

  # GET /student/course_user_tests/1
  # GET /student/course_user_tests/1.json
  def show
  end

  # GET /student/course_user_tests/new
  def new
    @student_course_user_test = Student::CourseUserTest.new
  end

  # GET /student/course_user_tests/1/edit
  def edit
  end

  # POST /student/course_user_tests
  # POST /student/course_user_tests.json
  def create
    @student_course_user_test = Student::CourseUserTest.new(student_course_user_test_params)

    respond_to do |format|
      if @student_course_user_test.save
        format.html { redirect_to @student_course_user_test, notice: 'Course user test was successfully created.' }
        format.json { render :show, status: :created, location: @student_course_user_test }
      else
        format.html { render :new }
        format.json { render json: @student_course_user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /student/course_user_tests/1
  # PATCH/PUT /student/course_user_tests/1.json
  def update
    respond_to do |format|
      if @student_course_user_test.update(student_course_user_test_params)
        format.html { redirect_to @student_course_user_test, notice: 'Course user test was successfully updated.' }
        format.json { render :show, status: :ok, location: @student_course_user_test }
      else
        format.html { render :edit }
        format.json { render json: @student_course_user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /student/course_user_tests/1
  # DELETE /student/course_user_tests/1.json
  def destroy
    @student_course_user_test.destroy
    respond_to do |format|
      format.html { redirect_to student_course_user_tests_url, notice: 'Course user test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student_course_user_test
      @student_course_user_test = Student::CourseUserTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_course_user_test_params
      params.require(:student_course_user_test).permit(:course_user_id, :test_id)
    end
end
