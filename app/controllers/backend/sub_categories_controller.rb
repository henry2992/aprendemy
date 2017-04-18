class Backend::SubCategoriesController < Backend::DashboardController
  before_action :set_category, only: [:index, :new, :create]
  before_action :set_sub_category, only: [:show, :edit, :update, :destroy] 

  def index
    @backend_sub_categories = @category.sub_categories
  end

  def show
  end

  def new
    @backend_sub_category = @category.sub_categories.new
  end

  def edit
  end

  def create
    @backend_sub_category = @category.sub_categories.new(sub_categories_params)

    respond_to do |format|
      if @backend_sub_category.save
        format.html { redirect_to backend_course_category_path(@backend_sub_category.category.course, @backend_sub_category.category), notice: 'Sub_category was successfully created.' }
        format.json { render :show, status: :created, location: backend_course_category_path(@backend_sub_category.category.course, @backend_sub_category.category) }
      else
        format.html { render :new }
        format.json { render json: @backend_sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @backend_sub_category.update(sub_categories_params)
        format.html { redirect_to backend_course_category_path(@backend_sub_category.category.course, @backend_sub_category.category), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: backend_course_category_path(@backend_sub_category.category.course, @backend_sub_category.category) }
      else
        format.html { render :edit }
        format.json { render json: @backend_sub_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @backend_sub_category.destroy
    respond_to do |format|
      format.html { redirect_to backend_course_category_path(@backend_sub_category.category.course, @backend_sub_category.category), notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    def set_category
      set_course && @category = @course.categories.find(params[:category_id])
    end

    def set_sub_category
      set_category && @backend_sub_category = @category.sub_categories.find(params[:id])
    end

    def sub_categories_params
      params.require(:sub_category).permit(:name, :description, :picture)
    end

end