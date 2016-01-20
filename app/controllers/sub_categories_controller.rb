class SubCategoriesController < ApplicationController
  before_filter :authenticate_user!

  def index
    get_category && @sub_categories = SubCategory.includes(:questions).sub_categories.all
  end

  def new
    @category = Category.find_by_id(params[:category_id])
    @sub_category = SubCategory.new
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @sub_category = @category.sub_categories.create(sub_category_params.merge(user_id: current_user)) if @category
    if @sub_category
      flash[:success] = "SubCategory '#{@sub_category.name}' has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
    redirect_to category_sub_category_path(@category, @sub_category)
  end

  def edit
    get_category && @sub_category = SubCategory.find_by_id(params[:id])
    render :new
  end

  def show
    get_category && @sub_category = SubCategory.find_by_id(params[:id])
    @questions = @sub_category.unanswered_questions(current_user.id)
    @question = Question.new
  end

  def show_answered_questions
    get_category && @sub_category = SubCategory.find_by_id(params[:sub_category_id])
    @questions = @sub_category.questions_answered(current_user.id)
    @question = Question.new
    render :show
  end

  def update
    get_category
    @sub_category = SubCategory.find_by_id(params[:id])
    @sub_category.update(sub_category_params) if @sub_category
    render :show
  end

  def delete
    SubCategory.find_by_id(params[:id]).destroy!
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name)
  end

  def get_category
    @category = Category.find_by_id(params[:category_id])
  end

end
