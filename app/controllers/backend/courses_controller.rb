class Backend::CoursesController < ApplicationController

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
    @backend_courses = Course.all.order(:id)
  end

  def show
  end

  def new
    @backend_course = Course.new
  end

  def edit
  end

  def create
    @backend_course = Course.new(courses_params)

    respond_to do |format|
      if @backend_course.save
        format.html { redirect_to backend_courses_path, notice: 'El curso fue creado de manera satisfactoria.' }
        format.json { render :show, status: :created, location: backend_course_path(@backend_course) }
      else
        format.html { render :new }
        format.json { render json: @backend_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @backend_course.update(courses_params)
        format.html { redirect_to backend_courses_path, notice: 'El curso fue actualizado correctamente.' }
        format.json { render :show, status: :ok, location: backend_course_path(@backend_course) }
      else
        format.html { render :edit }
        format.json { render json: @backend_course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @backend_course.destroy
    respond_to do |format|
      format.html { redirect_to backend_courses_url, notice: 'El curso fue eliminado de manera satisfactoria.' }
      format.json { head :no_content }
    end
  end

  private

  def set_course
    @backend_course = Course.find(params[:id])
  end

  def courses_params
    params.require(:course).permit(:name, :description, :author, :picture)
  end
end
