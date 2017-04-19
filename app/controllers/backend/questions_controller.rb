class Backend::QuestionsController < Backend::DashboardController
  before_action :set_question, only: [:show, :edit, :update, :destroy] 
  before_action :set_sub_category, only: [:new, :create] 

  def show
  end

  def new
    @backend_question = @sub_category.questions.new
  end

  def create
    @backend_question = @sub_category.questions.new(question_params)

    respond_to do |format|
      if @backend_question.save
        format.html { redirect_to backend_course_category_sub_category_path(@backend_question.sub_category.category.course, @backend_question.sub_category.category, @backend_question.sub_category), notice: 'Pregunta creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: backend_course_category_sub_category_path(@backend_question.sub_category.category.course, @backend_question.sub_category.category, @backend_question.sub_category) }
      else
        format.html { render :new }
        format.json { render json: @backend_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @backend_question.update(question_params)
        format.html { redirect_to backend_course_category_sub_category_path(@backend_question.sub_category.category.course, @backend_question.sub_category.category, @backend_question.sub_category), notice: 'Pregunta modificada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: backend_course_category_sub_category_path(@backend_question.sub_category.category.course, @backend_question.sub_category.category, @backend_question.sub_category) }
      else
        format.html { render :edit }
        format.json { render json: @backend_question.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @backend_question.destroy
    respond_to do |format|
      format.html { redirect_to backend_course_category_sub_category_path(@backend_question.sub_category.category.course, @backend_question.sub_category.category, @backend_question.sub_category), notice: 'Pregunta eliminada satisfactoriamente.' }
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
      set_category && @sub_category = @category.sub_categories.find(params[:sub_category_id])
    end
    
    def set_question
      set_sub_category && @backend_question = Question.find(params[:id])
    end

    def question_params
      params.require(:question).permit(:content, :explanation, :url, :video_url, :question_id, :picture)
    end
end
