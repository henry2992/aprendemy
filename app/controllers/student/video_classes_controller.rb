class Student::VideoClassesController < ApplicationController
 
  before_action :set_data
  before_action :set_video, only: [:show]

  def index
  	
    @categories = Category.all

  end

  def show
  end

  private

  def set_data
    @course = Course.find(params[:course_id])
  end

  def set_video
      @video = VideoClass.find(params[:id])
   end

end
