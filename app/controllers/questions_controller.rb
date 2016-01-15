class QuestionsController < ApplicationController

  def index
    get_category_and_sub && @questions = @sub_category.questions.includes(:choices).all
  end

  def new
    get_category_and_sub && @question = Question.new
  end

  def create
    get_category_and_sub
    @question = @sub_category.questions.create(question_params.merge(user_id: current_user))
    if @question
      flash[:success] = "New question has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
    show_questions_index
  end

  def edit
    get_category_and_sub && @question = Question.find_by_id(params[:id])
    render :new
  end

  def show
    get_category_and_sub && @question = Question.find_by_id(params[:id])
  end

  def update
    get_category_and_sub
    @question = Question.find_by_id(params[:id])
    @question.update(question_params) if @question
    show_questions_index
  end

  def delete
    Question.find_by_id(params[:id]).destroy!
    flash[:notice] = "Question has been deleted successfully"
    show_questions_index
  end

  private

  def question_params
    params.require(:question).permit(:content, :choice_id)
  end

  def get_category_and_sub
    @category = Category.find_by_id(params[:category_id])
    @sub_category = SubCategory.find_by_id(params[:sub_category_id])
  end

  def show_questions_index
    redirect_to category_sub_category_question_path(@category, @sub_category, @question)
  end
end
