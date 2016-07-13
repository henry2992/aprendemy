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
    course_user_test = CourseUserTest.where(course_user: @course_user, test: @test).first
    if !course_user_test
      @course_user_test = CourseUserTest.new(course_user: @course_user, test: @test)
      if @course_user_test.save
        @course_user_test.test.questions.each do |q|
          @course_user_test.answers.create!(user: current_user, question: q, choice_id: 1)
        end
      else
        redirect_to student_course_tests_path(@course), notice: 'Ha ocurrido un error al guardar'
      end
    else
      redirect_to student_course_tests_path(@course), notice: 'Ha ocurrido un error al guardar, verifique que ya no haya seleccionado este test'
    end
  end

  # GET /course_user_tests/1/edit
  def edit
  end

  # POST /course_user_tests
  # POST /course_user_tests.json
  def create

    # Este seria el ejemplo
    # tengo un test de 15 preguntas con 15 minutos de resolucion
    # entro y contesto 2 preguntas en 3 minutos
    # al siguiente dia entro y contesto 3 mas en 2 minutos
    # al siguiente dia ingreso y ya tengo contestadas 5 y me sobran 10 minutos
    # en ese momento digo me canse voy a calificarme y intento “terminar"
    # pero no me deja calificar mi test porque no cumpli con el 75% de avance
    # entonces decido completar
    # y doy calificar al completarlo
    # y obviamente solo ahi
    # me calcula las estaudticas y me muestra las respuesta
    # Lo registros nunca se borran
    # supongamos que un alumno tiene 10 preguntas y logro contestar tan solo 3
    # y se le agoto el tiempo
    # la calificacion seria en tal caso 3 correctas (si contesto las 3 bien ) y 7 incorrectas
    # entonces se califica de dos formas: la primera si el estudiante lo desea (solo al 75% de avance) y cuando el tiempo se agota
    # y ahi no importa el avance
    
    @course_user_test = CourseUserTest.new(course_user_test_params)
    total_questions = @course_user_test.test.questions.count
    answered_questions = params["course_user_test"]["question_ids"].count
    percent_to_go = total_questions * 75/100
    respond_to do |format|
      if answered_questions >= percent_to_go
        if @course_user_test.save
          params["course_user_test"]["question_ids"].each do |q|
            @course_user_test.answers.where(user: current_user, question_id: q[0]).update_attribute(:choice_id, q[1])
          end
          format.html { redirect_to student_course_tests_path, notice: 'Course user test was successfully created.' }
          format.json { render :show, status: :created, location: student_course_tests_path }
        else
          format.html { redirect_to new_student_course_test_course_user_test_path(@course,@test), notice: 'Ha ocurrido un error al guardar, verifique que ya no haya seleccionado este test' }
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
