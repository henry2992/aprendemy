class Student::ResourcesController < Student::StudentController
  before_action :set_resource, only: [:index, :show, :update]
  before_action :create_resource_progress, only: [:show, :update]
  before_action :destroy_answers, only: [:index]

  before_filter :redirect_if_premium_plan
  
  def index
    redirect_to student_show_resource_path(@resource)
  end

  def show
    add_breadcrumb "Inicio", :root_path
    @course = @resource.section.course
    add_breadcrumb "#{@resource.section.course.name}", student_course_path(@resource.section.course_id)
  end

  def update
    if completed?
      respond_to do |format|
        format.html { redirect_to student_show_resource_path(@resource), notice: 'Recurso marcado completado!' }
        format.json { render json: [:message => "recurso marcado completado!", :success => true ], status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to student_show_resource_path(@resource), alert: 'Recurso no fue completado correctamente!' }
        format.json { render json: [ :success => false ], status: :ok }
      end
    end
  end

  private

    # def create_resource_progress
    #   resource_progress = ResourceProgress.where(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id]).first
    #   if resource_progress == nil
    #     @resource_progress = ResourceProgress.create!(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id])
    #   else
    #     @resource_progress = ResourceProgress.where(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id]).first
    #   end
    # end

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
          success = true
          return false if !params['question_ids']
          return false if params['question_ids'].count != @resource.material.questions.count
          Answer.where(item: @resource.material, user: current_user).destroy_all
          params['question_ids'].each do |i, v|
            q = Question.find(i)
            if success
              success = false if q.choice_id != v.to_i
            end
            Answer.create!(item: @resource.material, question: q, user: current_user, choice_id: v.to_i)
          end
          return false if !success
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
      resource_data = {
        course_user: resource.section.course.course_users.where(course: resource.section.course, user: current_user).first,
        section: resource.section,
        resource: resource
      }
      resource_progress = ResourceProgress.where(resource_data).first
      if resource_progress
        if !resource_progress.completed
          Answer.where(item: resource_progress.resource.material, user: current_user).destroy_all
        end
      else
        Answer.where(item_id: params[:id], item_type:"Task", user: current_user).destroy_all
      end
    end

    def resource_params
      params.permit(:id)
    end

end
