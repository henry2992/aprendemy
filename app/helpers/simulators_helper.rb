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

  def show_flash
    if @questions
      flash[:success] = "simulator has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
  end
end
