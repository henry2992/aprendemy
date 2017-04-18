class Backend::ChoicesController < Backend::DashboardController
  before_action :set_choice, only: [:show, :edit, :update, :destroy] 
  before_action :set_question, only: [:new, :create] 

  # def show
  # end

  def new
    @backend_choice = @question.choices.new
  end

  def create
    @backend_choice = @question.choices.new(choice_params)

    respond_to do |format|
      if @backend_choice.save
        format.html { redirect_to backend_course_category_sub_category_question_path(@backend_choice.question.sub_category.category.course, @backend_choice.question.sub_category.category, @backend_choice.question.sub_category, @backend_choice.question), notice: 'Opción creada satisfactoriamente.' }
        format.json { render :show, status: :created, location: backend_course_category_sub_category_question_path(@backend_choice.question.sub_category.category.course, @backend_choice.question.sub_category.category, @backend_choice.question.sub_category, @backend_choice.question) }
      else
        format.html { render :new }
        format.json { render json: @backend_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @backend_choice.update(choice_params)
        format.html { redirect_to backend_course_category_sub_category_question_path(@backend_choice.question.sub_category.category.course, @backend_choice.question.sub_category.category, @backend_choice.question.sub_category, @backend_choice.question), notice: 'Opción modificada satisfactoriamente.' }
        format.json { render :show, status: :ok, location: backend_course_category_sub_category_question_path(@backend_choice.question.sub_category.category.course, @backend_choice.question.sub_category.category, @backend_choice.question.sub_category, @backend_choice.question) }
      else
        format.html { render :edit }
        format.json { render json: @backend_choice.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @backend_choice.destroy
    respond_to do |format|
      format.html { redirect_to backend_course_category_sub_category_question_path(@backend_choice.question.sub_category.category.course, @backend_choice.question.sub_category.category, @backend_choice.question.sub_category, @backend_choice.question), notice: 'Opción eliminada satisfactoriamente.' }
      format.json { head :no_content }
    end
  end

  private
  #   def set_course
  #     @course = Course.find(params[:course_id])
  #   end
    
  #   def set_category
  #     set_course && @category = @course.categories.find(params[:category_id])
  #   end

  #   def set_sub_category
  #     set_category && @sub_category = @category.sub_categories.find(params[:sub_category_id])
  #   end

    def set_question
      @question = Question.find(params[:question_id])
    end
    
    def set_choice
      @backend_choice = Choice.find(params[:id])
    end

    def choice_params
      params.require(:choice).permit(:content, :value_count)
    end

end
