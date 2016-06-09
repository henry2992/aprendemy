class Student::CourseTestUserController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
