class Student::CourseUserTestsController < ApplicationController
  before_action :load_course_user_test, only: [:new, :update, :edit]
  before_action :set_course_user_test, only: [:update, :set_answers, :show, :edit]

  # GET /course_user_tests
  # GET /course_user_tests.json
  def index
    add_breadcrumb "Inicio", :root_path
    @course_user_tests = CourseUserTest.all
  end

  def new
    add_breadcrumb "Inicio", :root_path
    course_user_test = CourseUserTest.where(course_user: @course_user, test: @test).first
    if !course_user_test && !CourseUserTest.where(course_user: @course_user, status: :paused).present?
      @course_user_test = CourseUserTest.new(course_user: @course_user, test: @test)
      @course_user_test.last_started = DateTime.now
      @course_user_test.time_left = @test.time_limit * 60
      if @course_user_test.save
        @course_user_test.test.questions.each do |q|
          @course_user_test.answers.create!(user: current_user, question: q)
        end
      else
        redirect_to student_course_tests_path(@course), notice: 'Ha ocurrido un error al guardar'
      end
    else
      redirect_to student_course_tests_path(@course), notice: 'Ha ocurrido un error al guardar, verifique que ya no haya seleccionado este test o tenga tests por completar'
    end
  end

  def edit
    if !@course_user_test.completed?
      if @course_user_test.paused?
        @course_user_test.last_started = Time.at(Time.now)
      end
      @course_user_test.time_left -= (Time.now.to_i - @course_user_test.last_started.to_i)
      @course_user_test.time_left = 0 if @course_user_test.time_left < 0
      @course_user_test.time_completed = Time.at(Time.now) if @course_user_test.time_left == 0
      @course_user_test.status = @course_user_test.time_left <= 0 ? "completed" : "opened"
      @course_user_test.last_started = Time.at(Time.now)
      @course_user_test.save
      return redirect_to student_course_tests_path(@course), notice: 'Test was successfully completed.' if @course_user_test.time_left == 0
    end
  end

  def update
    respond_to do |format|
      if params["course_user_test"]['action_form'] == "end"
        total_questions = @course_user_test.test.questions.count
        answered_questions = 0
        answered_questions = params["course_user_test"]["question_ids"].count if params["course_user_test"]["question_ids"]
        percent_to_go = total_questions * 75/100
        if @course_user_test.save
          if ( @course_user_test.time_left - (Time.now.to_i - @course_user_test.last_started.to_i) ) > 0
            set_answers params["course_user_test"]["question_ids"] if params["course_user_test"]["question_ids"]
          else
            @course_user_test.status = "completed" # :completed
            @course_user_test.time_completed = DateTime.now
            @course_user_test.save
            format.html { redirect_to student_course_tests_path(@course), notice: 'Sorry, time is over!, your answers have not been stored' }
            format.json { render :show, status: :created, location: student_course_tests_path(@course) }
          end
          if answered_questions >= percent_to_go
            @course_user_test.status = "completed" # :completed
            @course_user_test.time_completed = DateTime.now
            @course_user_test.save
            format.html { redirect_to student_course_tests_path(@course), notice: 'Test was successfully completed.' }
            format.json { render :show, status: :created, location: student_course_tests_path(@course) }
          else
            format.html { redirect_to student_course_tests_path(@course), notice: 'Your answers have been stored, but to end this test you must answer at least 75% of total questions.' }
            format.json { render :show, status: :created, location: student_course_tests_path(@course) }
          end
        else
          format.html { redirect_to new_student_course_test_course_user_test_path(@course,@test), notice: 'Ha ocurrido un error al guardar, verifique que ya no haya seleccionado este test' }
          format.json { render json: @course_user_test.errors, status: :unprocessable_entity }
        end
      end
      if params["course_user_test"]['action_form'] == "pause"
        set_answers params["course_user_test"]["question_ids"] if params["course_user_test"]["question_ids"]
        if @course_user_test.save
          format.html { redirect_to student_course_tests_path(@course), notice: 'Test was successfully paused.' }
          format.json { render :show, status: :created, location: student_course_tests_path(@course) }
        end
      end
    end
  end

  private

    def set_answers answers
      answers.each do |q|
        @course_user_test.answers.where(user: current_user, question_id: q[0]).update_all(choice_id: q[1])
      end
    end

    def load_course_user_test
      @course = Course.find(params[:course_id])
      @test = Test.find(params[:test_id])
      @course_user = CourseUser.where(course: @course, user: current_user).first if @course && @test
    end

    def set_course_user_test
      @course_user_test = CourseUserTest.where(course_user: @course_user, test: @test).first # :opened or :paused
    end

    def course_user_test_params
      params.require(:course_user_test).permit(:course_user_id, :test_id, :action_form, :question_ids => [])
    end
end
