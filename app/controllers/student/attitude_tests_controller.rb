class Student::AttitudeTestsController < Student::StudentController
  before_action :load_uat, only: [:show]
  # before_action :update_tests_data
  before_filter :check_plan, only: [:show]

  def index
  end

  def update
    uat = current_user.user_attitude_tests.find_by_test_id(params[:id])
    Answer.where(item: uat).destroy_all if !uat.blank?
    qs = vs = []
    qs = params['question_ids'].keys.map { |e| e } if params['question_ids']
    vs = params['question_ids'].values.map { |e| e } if params['question_ids']
    us = current_user.slice(:id)
    i = qs.map.with_index { |e, k| k }
    data = []
    i.each do |i|
      data[i] = { 
                  "question_id" => qs[i].to_i, 
                  "choice_id"   => vs[i].to_i,
                  "user_id"     => current_user.id,
                  "item_id"     => uat.id,
                  "item_type"   => "UserAttitudeTest"
                }

    end
    
    band = false

    if params['action_form'] == "end" && current_user.user_attitude_tests.find_by_test_id(params[:id]).test.questions.count == vs.count
      current_user.user_attitude_tests.find_by_test_id(params[:id]).update_attribute(:status,1)
      band = true
    end

    if Answer.create!(data) and !data.blank?
      if params['action_form'] == "pause" && current_user.user_attitude_tests.find_by_test_id(params[:id]).test.questions.count >= vs.count
        return redirect_to student_attitude_test_path(params['id']), notice: 'Test pausado correctamente, para finalizar un test debe contestar todas las preguntas' 
      end
      if band
        return redirect_to student_courses_path, notice: 'Hemos recibido tus pruebas de actitud, muy pronto recibiras tu resultados por email' 
      else
        return redirect_to student_courses_path, notice: 'Test pausado, para finalizar un test debe contestar todas las preguntas' 
      end
    else
      return redirect_to student_attitude_test_path(params['id']), alert: 'Ocurrió un error al actualizar este test'
    end
  end
  
  def show
  end
  
  private
    
    def load_uat
      current_user.user_attitude_tests.create!(test_id: params[:id]) unless current_user.user_attitude_tests.find_by_test_id(params[:id])
      @uat = current_user.user_attitude_tests.find_by_test_id(params[:id])
    end
end
