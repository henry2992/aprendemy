class Backend::AttitudeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_psicologist?
  before_action :set_attitude_test, only: [:show]
  before_action :set_user, only: [:update]

  def index
  end

  def show
  end

  def update
    data = {"attitude_test_observation" => params[:attitude_test]['attitude_test_observation']}
    respond_to do |format|
      if @u.update(data)
        format.html { redirect_to backend_attitude_index_path, notice: 'El test fue evaluado exitosamente' }
        format.json { render :show, status: :ok, location: @uat }
      else
        format.html { render :show }
        format.json { render json: @uat.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private
    def set_attitude_test
      @uat = UserAttitudeTest.find(params[:id])
    end
    def set_user
      @u = User.find(params[:id])
    end
end
