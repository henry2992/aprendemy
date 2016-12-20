class Student::AttitudeTestsController < Student::StudentController
  before_action :load_uat, only: [:show]
  # before_action :update_tests_data
  before_filter :check_plan, only: [:show]

  def index
  end

  def update
    current_user.user_attitude_tests.find_by_test_id(params[:id]).test.answers.destroy_all if current_user.user_attitude_tests.find_by_test_id(params[:id])
    qs = params['question_ids'].keys.map { |e| e }
    vs = params['question_ids'].values.map { |e| e }
    us = current_user.slice(:id)
    i = qs.map.with_index { |e, k| k }
    data = []
    i.each do |i|
      data[i] = { 
                  "question" => Question.find(qs[i].to_i), 
                  "choice"   => Choice.find(vs[i].to_i),
                  "user"     => current_user,
                  "item"   => Test.find(params['id'])
                }

    end
    if Answer.create!(data)
      if params['action_form'] == "pause" && current_user.user_attitude_tests.find_by_test_id(params[:id]).test.questions.count >= vs.count
        return redirect_to student_attitude_test_path(params['id']), notice: 'Test pausado correctamente, para finalizar un test debe contestar todas las preguntas' 
      end
      if params['action_form'] == "end" && current_user.user_attitude_tests.find_by_test_id(params[:id]).test.questions.count == vs.count
        current_user.user_attitude_tests.find_by_test_id(params[:id]).update_attribute(:status,1)
        return redirect_to student_courses_path, notice: 'Finalizado correctamente' 
      else
        return redirect_to student_courses_path, notice: 'Test pausado, para finalizar un test debe contestar todas las preguntas' 
      end
    else
      return redirect_to student_attitude_test_path(params['id']), alert: 'Ocurrió un error al actualizar este test'
    end
  end
  
  def show
    # @course_user = CourseUser.where(course: @course, user: current_user).first if @course
    
    # @tests = @course.tests.all.where(test_type: 0).where.not(id: CourseUserTest.where(course_user: @course_user).map(&:test_id)).order(:id) if @course_user
    # @course_user_tests = CourseUserTest.where(course_user: @course_user) if @course_user
  end
  
  private
    
    def load_uat
      current_user.user_attitude_tests.create!(test_id: params[:id]) unless current_user.user_attitude_tests.find_by_test_id(params[:id])
      @uat = current_user.user_attitude_tests.find_by_test_id(params[:id])
      # raise @uat.to_yaml
    end
end
