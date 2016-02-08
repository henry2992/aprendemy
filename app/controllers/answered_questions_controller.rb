class AnsweredQuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, only: [ :delete ]

  def index
    get_category_and_sub && @questions = @sub_category.questions.includes(:choices).all
  end

  def new
    get_category_and_sub && @question = Question.new
  end

  def create
    get_category_and_sub
    @answered_question = @question.answered_questions.create(answered_question_params)
    if @answered_question
      render :show
    end
  end

  def edit
    get_category_and_sub && @answered_question = AnsweredQuestion.find_by_id(params[:id])
    render :new
  end

  def show
    get_category_and_sub && @answered_question = AnsweredQuestion.find_by_id(params[:id])
  end

  def update
    get_category_and_sub
    @answered_question = AnsweredQuestion.find_by_id(params[:id])
    @answered_question.update(answered_question_params) if @answered_question
    render :show
  end

  def delete
    AnsweredQuestion.find_by_id(params[:id]).destroy!
    flash[:notice] = "Question has been deleted successfully"
    render :index
  end

  private

  def answered_question_params
    params.require(:answered_question).permit(:choice_id).merge({
      correct: answer_is_correct,
      user_id: current_user.id
    })
  end

  def get_category_and_sub
    @category = Category.find_by_id(params[:category_id])
    @sub_category = SubCategory.find_by_id(params[:sub_category_id])
    @question = Question.find_by_id(params[:question_id])
  end


  def answer_is_correct
    @question.choice_id == params[:answered_question][:choice_id].to_i
  end
end
