class Student::TestsController < ApplicationController
  before_filter :authenticate_user!
  # before_action :set_test, only: [:show, :edit, :update, :destroy]
  before_action :load_course

  def index
    @course_user = CourseUser.where(course: @course, user: current_user).first if @course
    @tests = Test.all.where.not(id: CourseUserTest.where(course_user: @course_user).map(&:test_id)) if @course_user 
    @course_user_tests = CourseUserTest.where(course_user: @course_user) if @course_user
  end

  # def show
  #   add_breadcrumb "Inicio", :root_path
  #   #@course_user = CourseUser.where(course_id: @course.id, user_id: current_user.id).first
  #   #@progress = @course_user.progress_percent
  #   # @test = Test.first
  # end

  # def new
  #   add_breadcrumb "Inicio", :root_path
  #   # add_breadcrumb "#{@course.name}", student_course_path(@course)
  #   @test = Test.new
  # end

  # def edit
  # end

  # def create
  #   # @course = Course.new(course_params)

  #   # respond_to do |format|
  #   #   if @course.save
  #   #     format.html { redirect_to @course, notice: 'Course was successfully created.' }
  #   #     format.json { render :show, status: :created, location: @course }
  #   #   else
  #   #     format.html { render :new }
  #   #     format.json { render json: @course.errors, status: :unprocessable_entity }
  #   #   end
  #   # end
  # end

  # # PATCH/PUT /tests/1
  # # PATCH/PUT /tests/1.json
  # def update
  #   # respond_to do |format|
  #   #   if @course.update(course_params)
  #   #     format.html { redirect_to @course, notice: 'Course was successfully updated.' }
  #   #     format.json { render :show, status: :ok, location: @course }
  #   #   else
  #   #     format.html { render :edit }
  #   #     format.json { render json: @course.errors, status: :unprocessable_entity }
  #   #   end
  #   # end
  # end

  # # DELETE /tests/1
  # # DELETE /tests/1.json
  # def destroy
  #   # @course.destroy
  #   # respond_to do |format|
  #   #   format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
  #   #   format.json { head :no_content }
  #   # end
  # end

  private

    def load_course
      @course = Course.find(params[:course_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    # def set_test
    #   @test = Test.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def test_params
    #   params.require(:test).permit(:name, :description)
    # end
end
