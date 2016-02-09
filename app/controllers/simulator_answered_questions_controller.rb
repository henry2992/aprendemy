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
    @answered_question = @question.answered_questions.create(answered_question_params)
    if @answered_question
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
    render :show
  end

  def delete
    SimulatorAnsweredQuestion.find_by_id(params[:id]).destroy!
    flash[:notice] = "Question has been deleted successfully"
    show_answered_question
  end

  private

  def answered_question_params
    params.require(:simulator_answered_question).permit(:choice_id).merge({
      status: answer_is_correct,
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

  def answer_is_correct
    status = (@question.choice_id == params[:simulator_answered_question][:choice_id].to_i) ? 'correct' : 'wrong'
  end

end
