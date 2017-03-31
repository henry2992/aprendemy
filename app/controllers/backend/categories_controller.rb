class Backend::CategoriesController < Backend::DashboardController
  before_action :set_course, only: [:index, :new, :create]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @backend_categories = @course.categories
  end

  def show
  end

  def new
    @backend_category = @course.categories.new
  end

  def edit
  end

  def create
    @backend_category = @course.categories.new(categories_params)

    respond_to do |format|
      if @backend_category.save
        format.html { redirect_to backend_course_path(@backend_category.course), notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: backend_course_path(@backend_category.course) }
      else
        format.html { render :new }
        format.json { render json: @backend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @backend_category.update(categories_params)
        format.html { redirect_to backend_course_path(@backend_category.course), notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: backend_course_path(@backend_category.course) }
      else
        format.html { render :edit }
        format.json { render json: @backend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @backend_category.destroy
    respond_to do |format|
      format.html { redirect_to backend_course_path(@backend_category.course), notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_course
      @course = Course.find(params[:course_id])
    end
    
    def set_category
      set_course
      @backend_category = @course.categories.find(params[:id])
    end

    def categories_params
      params.require(:category).permit(:name)
    end

end