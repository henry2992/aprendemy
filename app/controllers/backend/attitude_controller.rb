class Backend::AttitudeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_psicologist?
  before_action :set_attitude_test

  def index
  end
  
  private
    def set_attitude_test
      @uat = UserAttitudeTest.completed
    end
end
