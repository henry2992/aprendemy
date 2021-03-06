class Student::CategoriesController < Student::StudentController
  before_action :set_data
  before_filter :authenticate_user!
  before_filter :check_plan, only: [:index]
  before_filter :user_is_admin?, except: [:index, :show]

  
  def index
    @categories = @course.categories.all

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


  private

  def category_params
    params.require(:category).permit(:name)
  end

   def set_data
      @course = Course.find(params[:course_id])
    end

end
