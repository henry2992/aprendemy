class Backend::CategoriesController < Backend::DashboardController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /backend/categories
  # GET /backend/categories.json
  def index
    @backend_categories = Category.all
  end

  # GET /backend/categories/1
  # GET /backend/categories/1.json
  def show
  end

  # GET /backend/categories/new
  def new
    @backend_category = Category.new
  end

  # GET /backend/categories/1/edit
  def edit
  end

  # POST /backend/categories
  # POST /backend/categories.json
  def create
    @backend_category = Category.new(categories_params)

    respond_to do |format|
      if @backend_category.save
        format.html { redirect_to backend_categories_path, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: backend_category_path(@backend_category) }
      else
        format.html { render :new }
        format.json { render json: @backend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /backend/categories/1
  # PATCH/PUT /backend/categories/1.json
  def update
    respond_to do |format|
      if @backend_category.update(categories_params)
        format.html { redirect_to backend_categories_path, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: backend_category_path(@backend_category) }
      else
        format.html { render :edit }
        format.json { render json: @backend_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /backend/categories/1
  # DELETE /backend/categories/1.json
  def destroy
    @backend_category.destroy
    respond_to do |format|
      format.html { redirect_to backend_categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @backend_category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categories_params
      params.require(:category).permit(:name)
    end

end
