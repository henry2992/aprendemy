class SubCategoriesController < ApplicationController

  def index
    @categories = SubCategory.all
  end

  def new
    @category = Category.find_by_id(params[:category_id])
    @sub_category = SubCategory.new
  end

  def create
    @category = Category.find_by_id(params[:category_id])
    @sub_category = @category.sub_categories.create(sub_category_params) if @category
    if @sub_category
      flash[:success] = "SubCategory '#{@sub_category.name}' has been created successfully"
    else
      flash[:danger] = "An error occured. Please try again."
    end
    redirect_to category_sub_category_path(@category, @sub_category)
  end

  def edit
    @sub_category = SubCategory.find_by_id(params[:id])
    render :new
  end

  def show
    @sub_category = SubCategory.find_by_id(params[:id])
  end

  def update
    @sub_category = SubCategory.find_by_id(params[:id])
    @sub_category.update(sub_category_params) if @sub_category
  end

  def delete
    SubCategory.find_by_id(params[:id]).destroy!
  end

  private

  def sub_category_params
    params.require(:sub_category).permit(:name)
  end

end
