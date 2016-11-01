class Backend::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?

  def index
  end
  
end
