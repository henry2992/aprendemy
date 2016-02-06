class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include ApplicationHelper, AnsweredQuestionsHelper

  def render_js_only
    respond_to do |format|
      format.js
      format.html { redirect_to "#{root_path}##{params[:action]}"}
    end
  end
end
