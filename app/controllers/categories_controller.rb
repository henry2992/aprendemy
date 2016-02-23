class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, except: [ :index, :show ]

  # Helper Methods for Devise Start
  helper_method :resource_name, :resource, :devise_mapping

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # Helper Methods for Devise End

  def index
    @categories = Category.all.includes(:sub_categories)
    @series = []
    @sub_category_names = []
  end

  def new
    @category = Category.new
    render_js_only
  end

  def create
    @category = current_user.categories.create(category_params)
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
    @category = Category.includes(:sub_categories).find_by_id(params[:id])
    render_js_only
  end

  def update
    @category = Category.find_by_id(params[:id])
    @category.update(category_params) if @category
    render :show
  end

  def delete
    Category.find_by_id(params[:id]).destroy!
  end

  def filter_chart
    # our logic to filter chart by separate categories will be here
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

end
