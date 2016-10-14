class Student::ResourcesController < Student::StudentController
  before_action :set_data
  before_action :set_resource, only: [:show, :show, :update]
  before_action :create_resource_progress, only: [:show, :update]
  before_action :destroy_answers, only: [:show]

  before_filter :check_plan
  before_filter :redirect_if_premium_plan
  
  def show
    add_breadcrumb "Inicio", :root_path
    @course = @resource.section.course
    course_resources = @course.sections.all.map{ |s| s.resources.order(:position,:created_at).map(&:id) }.flatten
    current_resource_index = course_resources.index(@resource.id)
    @prev = current_resource_index == 0 ? nil :  Resource.find(course_resources[current_resource_index-1])
    
    if @prev
      resource = Resource.find(@prev)
      resource_data = {
        course_user: @course_user,
        section: resource.section,
        resource: resource
      }
      resource_progress = ResourceProgress.find_by(resource_data)
      # Habilitar si se quiere bloquear de nuevo el progreso
      # return redirect_to student_course_progress_resource_path(@course,@course,@prev), notice: 'Usted debe completar esta tarea para pasar a la siguiente' if !resource_progress.completed?
    end
    
    @next = current_resource_index == course_resources.index(course_resources.last) ? nil : Resource.find(course_resources[current_resource_index+1])
    add_breadcrumb "#{@resource.section.course.name} ", student_course_path(@resource.section.course_id)
    add_breadcrumb "Progress", student_course_progress_index_path(@resource.section.course_id)
  end

  def update
    if completed?
      respond_to do |format|
        format.html { redirect_to student_course_progress_resource_path(@course,1,@resource), notice: 'Recurso marcado completado!' }
        format.json { render json: [:message => "recurso marcado completado!", :success => true ], status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to student_course_progress_resource_path(@course,1,@resource), alert: 'Recurso no fue completado correctamente!' }
        format.json { render json: [ :success => false ], status: :ok }
      end
    end
  end

  private

    def create_resource_progress
      resource_data = {
        course_user: @resource.section.course.course_users.where(course: @resource.section.course, user: current_user).first,
        section: @resource.section,
        resource: @resource
      }

      resource_progress = ResourceProgress.where(resource_data).first
      if !resource_progress.present?
        @resource_progress = ResourceProgress.create!(resource_data)
      else
        @resource_progress = resource_progress
      end
    end

    def completed?
      case @resource.material_type
        when "Video", "Blog"
          return false if (@resource_progress.completed? || !@resource_progress.update_attributes(completed: true))
          return true
        when "Task"
          return false if @resource_progress.completed
          return false if !params['question_ids']
          return false if params['question_ids'].count != @resource.material.questions.count
          Answer.where(item: @resource.material, user: current_user).destroy_all
          params['question_ids'].each do |i, v|
            q = Question.find(i)
            Answer.create!(item: @resource.material, question: q, user: current_user, choice_id: v.to_i)
          end
          return true if @resource_progress.update_attributes(completed: true)
          return false
      end
      return false
    end

    def set_resource
      @resource = Resource.find(params[:id])
      if @resource.material_type == "Task"
        a = Answer.where(item: @resource.material, user: current_user)
        if a.first
          @answers = a
        end
      end
    end

    def destroy_answers
      resource = Resource.find(params[:id])
      if resource.material_type == "Task"
        resource_data = {
          course_user: resource.section.course.course_users.where(course: resource.section.course, user: current_user).first,
          section: resource.section,
          resource: resource
        }
        resource_progress = ResourceProgress.where(resource_data).first
        if resource_progress
          if !resource_progress.completed
            resource_progress.resource.material.answers.destroy_all
          end
        else
          Answer.where(item_id: params[:id], item_type:"Task", user: current_user).destroy_all
        end
      end
    end

    def resource_params
      params.permit(:id)
    end

    def set_data
      @course_user = CourseUser.where(course_id: params[:course_id], user: current_user).first
      @progress = @course_user.progress_percent
      @course = Course.find(params[:course_id])
    end

end
