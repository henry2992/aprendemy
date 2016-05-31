class SimulatorsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, only: [:delete]
  include SimulatorsHelper

  def index
    init_class_variables
  end

  def new
    @simulator = simulator.new
    render_js_only
  end

  def create
    unless unfinished_simulator_exists
      simulator_type = get_simulator_type params[:simulator_type_id]
      if simulator_type && create_simulator(simulator_type)
        get_individual_questions_for_simulator get_total_questions_per_category(simulator_type)
      end
    end
    check_for_time_left @simulator
    render :show
  end

  def show_answered_questions
    @simulator = current_user.simulators.find_by_id(params[:simulator_id])
    @questions = @simulator.answered_questions_list if @simulator
    # @questions = @questions.paginate(page: params[:page], per_page: 3)
    render :show
  end

  def show
    @simulator = current_user.simulators.includes(:questions).find_by_id(params[:id])
    @questions = @simulator.questions if @simulator
    # @questions = @questions.paginate(page: params[:page], per_page: 3)
    @simulated_categories = SimulatedCategory.all
    check_for_time_left(@simulator) if @simulator
  end

  def update
    @simulator = Simulator.find_by_id(params[:id])
    @simulator.update(simulator_params) if @simulator
    render :show
  end

  def delete
    simulator.find_by_id(params[:id]).destroy!
  end

  def pause_simulator
    @simulator = Simulator.find_by_id(params[:simulator_id])
    @message = !@simulator.completed? ? save_simulator_time : "You have previously completed this simulator. You cannot further modify it"
    respond_to {|format| format.json {render partial: "pause_simulator.js" } } if @simulator
  end

  def finish_simulator
    @simulator = Simulator.find_by_id(params[:simulator_id])
    current_time = params[:timer]
    update_if_greater_than_70_percent current_time
    respond_to {|format| format.js {render partial: "pause_simulator.js" } }
  end

  def filter_chart
    init_class_variables
    @filter_args = { model: params[:model], id: params[:model_id], model_name: params[:model_name]}
    respond_to {|format| format.json {render partial: "chart.js" } }
  end

  private

  def simulator_params
    params.require(:simulator).permit(:name)
  end

end
