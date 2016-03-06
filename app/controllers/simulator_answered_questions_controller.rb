class SimulatorAnsweredQuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, only: [ :delete ]

  def index
    get_simulator_and_question
  end

  def new
    get_simulator_and_question && @question = Question.new
  end

  def create
    get_simulator_and_question
    @answered_question = SimulatorAnsweredQuestion.find_or_create_by(simulator_id: @simulator.id, question_id: @question.id, user_id: current_user.id)
    if @answered_question
      @answered_question.update(answered_question_params)
      get_clue_class
      render :show
    end
  end

  def edit
    get_simulator_and_question && @answered_question = SimulatorAnsweredQuestion.find_by_id(params[:id])
    render :new
  end

  def show
    get_simulator_and_question
    @questions = @simulator.questions
  end

  def update
    get_simulator_and_question
    @answered_question.update(answered_question_params) if @answered_question
    get_clue_class
    render :show
  end

  def delete
    SimulatorAnsweredQuestion.find_by_id(params[:id]).destroy!
    flash[:notice] = "Question has been deleted successfully"
    show_answered_question
  end

  private

  def answered_question_params
    params.require(:simulator_answered_question).permit(:choice_id, :marked_status).merge({
      status: answer_status,
      user_id: current_user.id
    })
  end

  def get_simulator_and_question
    @simulator = Simulator.find_by_id(params[:simulator_id])
    @question = Question.find_by_id(params[:question_id])
    @answered_question = SimulatorAnsweredQuestion.find_by(simulator_id: @simulator.id, question_id: @question.id)
  end

  def show_answered_question
    redirect_to :show
  end

  def answer_status
    user_choice = params[:simulator_answered_question][:choice_id]
    (@question.choice_id == user_choice.to_i  ? 'correct' : 'wrong' if user_choice) || 'unanswered'
  end

  def get_clue_class
    @clue_class = clue_status(!@answered_question.unanswered?,  @answered_question.marked?)
  end
end
