class Student::ResourcesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_resource, only: [:show, :update]
  before_action :create_resource_progress, only: [:show]

  def show
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@resource.section.course.name}", student_course_path(@resource.section.course_id)
  end

  def update
    @resource_progress = ResourceProgress.find(params[:resource_progress_id])
    if completed?
      redirect_to student_course_path(@resource_progress.course_user.course), notice: 'recurso marcado completado!'
    else
      redirect_to student_course_path(@resource_progress.course_user.course), alert: 'recurso no fue completado correctamente!'
    end
  end

  private
    def create_resource_progress
      resource_progress = ResourceProgress.where(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id]).first
      if resource_progress == nil
        @resource_progress = ResourceProgress.create!(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id])
      else
        @resource_progress = ResourceProgress.where(course_user_id: params[:course_user_id], section_id: params[:section_id], resource_id: params[:id]).first
      end
    end

    def completed?
      case @resource.material_type
        when "Video"
          #obtener el evento cuando termina un video y marcarlo completado
          false
        when "Blog"
          @resource_progress.update_attributes(completed: true)
        when "Task"
          #validar que el formulario esta respondido correctamente y marcarlo completado
          false
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name)
    end

end
