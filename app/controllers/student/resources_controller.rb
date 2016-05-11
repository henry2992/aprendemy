class Student::ResourcesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
    add_breadcrumb "Inicio", :root_path
    add_breadcrumb "#{@resource.section.course.name}", student_course_path(@resource.section.course_id)
  end
  
  def create
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource
      @resource = Resource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_params
      params.require(:resource).permit(:name)
    end

end
