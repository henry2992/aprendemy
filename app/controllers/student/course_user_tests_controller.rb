class CourseUserTestsController < ApplicationController
  before_action :set_course_user_test, only: [:show, :edit, :update, :destroy]

  # GET /course_user_tests
  # GET /course_user_tests.json
  def index
    @course_user_tests = CourseUserTest.all
  end

  # GET /course_user_tests/1
  # GET /course_user_tests/1.json
  def show
  end

  # GET /course_user_tests/new
  def new
    @course_user_test = CourseUserTest.new
  end

  # GET /course_user_tests/1/edit
  def edit
  end

  # POST /course_user_tests
  # POST /course_user_tests.json
  def create
    @course_user_test = CourseUserTest.new(course_user_test_params)

    respond_to do |format|
      if @course_user_test.save
        format.html { redirect_to @course_user_test, notice: 'Course user test was successfully created.' }
        format.json { render :show, status: :created, location: @course_user_test }
      else
        format.html { render :new }
        format.json { render json: @course_user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_user_tests/1
  # PATCH/PUT /course_user_tests/1.json
  def update
    respond_to do |format|
      if @course_user_test.update(course_user_test_params)
        format.html { redirect_to @course_user_test, notice: 'Course user test was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_user_test }
      else
        format.html { render :edit }
        format.json { render json: @course_user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_user_tests/1
  # DELETE /course_user_tests/1.json
  def destroy
    @course_user_test.destroy
    respond_to do |format|
      format.html { redirect_to course_user_tests_url, notice: 'Course user test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_user_test
      @course_user_test = CourseUserTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_user_test_params
      params.require(:course_user_test).permit(:course_user_id, :test_id)
    end
end
