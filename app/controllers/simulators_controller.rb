class SimulatorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, only: [ :delete ]
  include SimulatorsHelper

  def index
    @simulators = current_user.simulators
    @simulator_types = SimulatorType.all
  end

  def new
    @simulator = simulator.new
    render_js_only
  end

  def create
    simulator_type = get_simulator_type params[:simulator_type_id]
    if simulator_type && create_simulator(simulator_type)
      get_individual_questions_for_simulator get_total_questions_per_category(simulator_type)
      # show_flash
    end
    render :show
  end

  def show_answered_questions
    @simulator = current_user.simulators.find_by_id(params[:simulator_id])
    @questions = @simulator.questions_answered if @simulator
    render :show
  end

  def show
    @simulator = current_user.simulators.includes(:questions).find_by_id(params[:id])
    @questions = @simulator.questions if @simulator
    @simulated_categories = SimulatedCategory.all
  end

  def update
    @simulator = Simulator.find_by_id(params[:id])
    @simulator.update(simulator_params) if @simulator
    render :show
  end

  def delete
    simulator.find_by_id(params[:id]).destroy!
  end

  private

  def simulator_params
    params.require(:simulator).permit(:name)
  end

end
