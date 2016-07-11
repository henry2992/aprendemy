class Student::CourseUserTestsController < ApplicationController
  before_action :set_course_user_test, only: [:show, :edit, :update, :destroy]
  before_action :load_course_user_test, only: [:new]

  # GET /course_user_tests
  # GET /course_user_tests.json
  def index
    add_breadcrumb "Inicio", :root_path
    @course_user_tests = CourseUserTest.all
  end

  # GET /course_user_tests/1
  # GET /course_user_tests/1.json
  def show
  end

  # GET /course_user_tests/new
  def new
    add_breadcrumb "Inicio", :root_path
    @course_user_test = CourseUserTest.new(course_user: @course_user, test: @test)
  end

  # GET /course_user_tests/1/edit
  def edit
  end

  # POST /course_user_tests
  # POST /course_user_tests.json
  def create
    @course_user_test = CourseUserTest.new(course_user_test_params)
    total_questions = @course_user_test.test.questions.count
    answered_questions = params["course_user_test"]["question_ids"].count
    percent_to_go = total_questions * 75/100
    respond_to do |format|
      if answered_questions >= percent_to_go
        if @course_user_test.save
          format.html { redirect_to student_course_tests_path, notice: 'Course user test was successfully created.' }
          format.json { render :show, status: :created, location: student_course_tests_path }
        else
          format.html { render :new }
          format.json { render json: @course_user_test.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to student_course_tests_path, notice: 'You must answer at least 75% of total questions.' }
        format.json { render :show, status: :created, location: student_course_tests_path }
      end
    end
  end

  # PATCH/PUT /course_user_tests/1
  # PATCH/PUT /course_user_tests/1.json
  def update
    # respond_to do |format|
    #   if @course_user_test.update(course_user_test_params)
    #     format.html { redirect_to @course_user_test, notice: 'Course user test was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @course_user_test }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @course_user_test.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /course_user_tests/1
  # DELETE /course_user_tests/1.json
  def destroy
    # @course_user_test.destroy
    # respond_to do |format|
    #   format.html { redirect_to course_user_tests_url, notice: 'Course user test was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  private
    def load_course_user_test
      @course = Course.find(params[:course_id])
      @test = Test.find(params[:test_id])
      @course_user = CourseUser.where(course: @course, user: current_user).first if @course && @test
    end

  # Use callbacks to share common setup or constraints between actions.
    def set_course_user_test
      @course_user_test = CourseUserTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_user_test_params
      # params["course_user_test"]["question_ids"] ||= []
      params.require(:course_user_test).permit(:course_user_id, :test_id, question_ids: [])
    end
end
