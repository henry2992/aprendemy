class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.create(category_params)
    if @category
      flash[:success] = "Category '#{@category.name}' has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
    redirect_to categories_path
  end

  def edit
    @category = Category.find_by_id(params[:id])
    render :new
  end

  def show
    @category = Category.find_by_id(params[:id])
  end

  def update
    @category = Category.find_by_id(params[:id])
    @category.update(category_params) if @category
  end

  def delete
    Category.find_by_id(params[:id]).destroy!
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
