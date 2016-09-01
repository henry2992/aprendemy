class Student::CourseUserTestsController < Student::StudentController
  before_action :load_course_user_test, only: [:new, :update, :edit]
  before_action :set_course_user_test, only: [:update, :set_answers, :show, :edit]
  before_filter :check_plan, only: [:index]

  def new
    add_breadcrumb "Inicio", :root_path
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
      return redirect_to student_course_tests_path(@course), notice: 'El Test fue completado exitosamente.' if @course_user_test.time_left == 0
    end
  end

  def update
    respond_to do |format|
      if params["course_user_test"]['action_form'] == "end"
        final_questions = params["course_user_test"]["question_ids"].reject {|key,value| value == "marked" } if params["course_user_test"]["question_ids"]
        total_questions = @course_user_test.test.questions.count
        answered_questions = 0
        answered_questions = final_questions.count if final_questions
        percent_to_go = total_questions * 75/100
        if @course_user_test.save
          if ( @course_user_test.time_left - (Time.now.to_i - @course_user_test.last_started.to_i) ) > 0
            set_answers params["course_user_test"]["question_ids"] if params["course_user_test"]["question_ids"]
          else
            @course_user_test.status = "completed" # :completed
            @course_user_test.time_completed = DateTime.now
            @course_user_test.time_left = 0
            @course_user_test.save
            format.html { redirect_to student_course_tests_path(@course), notice: 'Lo siento, ¡el tiempo de ha consumido!, yus respuestas no han sido almacenadas, ahora este Test está completado.' }
            format.json { render :show, status: :created, location: student_course_tests_path(@course) }
          end
          if answered_questions >= percent_to_go
            @course_user_test.status = "completed" # :completed
            @course_user_test.time_completed = DateTime.now
            @course_user_test.time_left = 0
            @course_user_test.save
            format.html { redirect_to student_course_tests_path(@course), notice: 'Test was successfully completed.' }
            format.json { render :show, status: :created, location: student_course_tests_path(@course) }
          else
            format.html { redirect_to student_course_tests_path(@course), notice: 'Tus respuestas han sido almacenadas, pero para completar este test debes responder al menos el 75% del total de las preguntas.' }
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
          format.html { redirect_to student_course_tests_path(@course), notice: 'El Test fue pausado exitosamente.' }
          format.json { render :show, status: :created, location: student_course_tests_path(@course) }
        end
      end
    end
  end

  private

    def set_answers answers
      answers.each do |q|
        marked = q[1] == "marked" ? 1 : 0
        if marked == 1
          @course_user_test.answers.where(user: current_user, question_id: q[0]).update_all(marked: 1)
        else
          @course_user_test.answers.where(user: current_user, question_id: q[0]).update_all(choice_id: q[1],marked: 0)
        end
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
