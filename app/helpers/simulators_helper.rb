module SimulatorsHelper

  def get_simulator_type id
    SimulatorType.find_by_id(id) if id
  end

  def get_total_questions_per_category simulator_type
    cat_count = SimulatedCategory.count
    ((simulator_type.total_questions / cat_count) unless cat_count == 0) || 0
  end

  def get_individual_questions_for_simulator questions_per_category
    @questions = []
    @simulated_categories = SimulatedCategory.includes(:category).all
    @simulated_categories.each do |simul|
      @questions = @questions + simul.category.questions.limit(questions_per_category).order("RANDOM()")
    end
    question_ids = @questions.map { |q|  q.id }
    QC.enqueue "SimulatorAnsweredQuestion.create_simulation_questions", question_ids, current_user.id, @simulator.id
  end

  def create_simulator simulator_type
    @simulator = Simulator.create(simulator_type_id: simulator_type.id, user_id: current_user.id, time_left: simulator_type.time_duration)
  end

  def check_for_time_left
    @simulator.update(time_left: @simulator.simulator_type.time_duration) unless @simulator.time_left
  end

  def show_flash
    if @questions
      flash[:success] = "simulator has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
  end

  def save_simulator_time
    current_time = params[:timer]
    message = ""
    if current_time.eql?('00:00:00')
      message = "This simulation has been completed" if @simulator.update(time_completed: Time.now, time_left: current_time, status: 'completed')
    else
      message = "This simulation has been paused" if @simulator.update(last_paused: Time.now, time_left: current_time || @simulator.time_left, status: 'paused')
    end
  end

  def init_class_variables
    @simulators = current_user.simulators.order(updated_at: :asc)
    @simulator_types = SimulatorType.all
    @simulated_categories = SimulatedCategory.all
    @series = []
    @simulator_dates = []
  end

  def mark_unanswered_questions_as_wrong unanswered_questions
     unanswered_questions.each do |question|
       question.simulator_answered_questions.find_or_create_by(user_id: current_user.id, status: :wrong, simulator_id: @simulator.id)
     end
  end

  def unfinished_simulator_exists
    @simulator = current_user.simulators.paused.first
    @questions = @simulator.questions if @simulator
    @simulated_categories = SimulatedCategory.all
    flash[:notice] = "This is your previously incompleted simulator. \
        You are not allowed to start a fresh one until you complete this one"
  end

  def update_if_greater_than_70_percent current_time
    unanswered_questions = @simulator.answered_not
    questions_count = @simulator.questions.count
    average_unanswered = (unanswered_questions.count / questions_count) * 100
    if average_unanswered >= 70 || current_time.eql?('00:00:00')
      mark_unanswered_questions_as_wrong unanswered_questions
      @message = current_time.eql?('00:00:00') ? "Unfortunately, your time is up!" : "Congratulations on completing this Simulator!"; @simulator.update(time_completed: Time.now, time_left: current_time, status: 'completed') if @simulator
    else
      @message = "You haven't answered 70% of the questions. Your simulator is only paused, not completed"
      @simulator.update(time_completed: Time.now, time_left: current_time, status: 'paused') if @simulator
    end
  end

end
