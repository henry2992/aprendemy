class Student::ResourcesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_resource, only: [:show, :update]
  before_action :create_resource_progress, only: [:show, :update]

  def show
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@resource.section.course.name}", student_course_path(@resource.section.course_id)
  end

  def update
    if completed?
      respond_to do |format|
        format.html { redirect_to student_course_path(@resource_progress.course_user.course), notice: 'recurso marcado completado!' }
        format.json { render json: [:message => "recurso marcado completado!", :success => true ], status: :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to student_course_path(@resource_progress.course_user.course), alert: 'recurso no fue completado correctamente!' }
        format.json { render json: [ :success => false ], status: :ok }
      end
    end
  end

  private
  
    def create_resource_progress
      resource_data = {
        course_user: @resource.section.course.course_users.where(course: @resource.section.course).first,
        section: @resource.section,
        resource: @resource
      }
      resource_progress = ResourceProgress.where(resource_data).first
      if !resource_progress.present?
        @resource_progress = ResourceProgress.create!(resource_data)
      else
        @resource_progress = ResourceProgress.where(resource_data).first
      end
    end

    def completed?
      case @resource.material_type
        when "Video", "Blog"
          return false if (@resource_progress.completed? || !@resource_progress.update_attributes(completed: true))
          return true
        when "Task"
          params['question_ids'].each do |i, v|
            q = Question.find(i)
            return false if q.choice_id != v.to_i
          end
          return true if @resource_progress.update_attributes(completed: true)
          return false
      end
      return false
    end

    def set_resource
      @resource = Resource.find(params[:id])
    end

    def resource_params
      params.permit(:id)
    end

end
