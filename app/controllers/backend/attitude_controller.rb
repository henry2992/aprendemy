class Backend::AttitudeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_psicologist?
  before_action :set_attitude_test, only: [:show, :update]

  def index
    @uat = UserAttitudeTest.order(created_at: :desc).where.not(status: 0)
  end

  def show
  end

  def update
    data = {"observation" => params[:attitude_test]['observation'], "status": 2}
    respond_to do |format|
      if @uat.update(data)
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
end
