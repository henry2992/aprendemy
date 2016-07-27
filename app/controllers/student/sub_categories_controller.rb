class Student::SubCategoriesController < Student::StudentController
  before_filter :authenticate_user!
  before_filter :user_is_admin?, only: [:edit, :delete]

  before_action :set_data, only: [:show]
  before_action :load_course, only: [:show]

  # def index
  #   get_category && @sub_categories = SubCategory.includes(:questions).sub_categories.all
  # end

  def new
    # @category = Category.find_by_id(params[:category_id])
    # @sub_category = SubCategory.new
    # render_js_only
    # @course_user_test = CourseUserTest.new(course_user: @course_user, test: @test)
    # @course_user_test.last_started = DateTime.now
    # @course_user_test.time_left = @test.time_limit * 60
    # if @course_user_test.save
    #   @course_user_test.test.questions.each do |q|
    #     @course_user_test.answers.create!(user: current_user, question: q)
    #   end
    # else
    #   redirect_to student_course_tests_path(@course), notice: 'Ha ocurrido un error al guardar'
    # end
  end

  def create
    # @category = Category.find_by_id(params[:category_id])
    # @sub_category = @category.sub_categories.create(sub_category_params.merge(user_id: current_user)) if @category
    # if @sub_category
    #   flash[:success] = "SubCategory '#{@sub_category.name}' has been created successfully"
    # else
    #   flash[:danger] = "An error occured. Please try again."
    # end
    # redirect_to category_sub_category_path(@category, @sub_category)
  end

  def edit
    # get_category && @sub_category = SubCategory.find_by_id(params[:id])
    # render :new
  end

  # Debe mostrar las preguntas de una categoría
  def show
    # raise @questions.as_json.to_yaml
    # raise get_category.as_json.to_yaml
    # get_category && @sub_category = SubCategory.find_by_id(params[:id])
    # @questions = @sub_category.unanswered_questions(current_user.id).page(params[:page]).per(10)
    # @question = Question.new
    # render_js_only
  end

  def show_answered_questions
    # get_category && @sub_category = SubCategory.find_by_id(params[:sub_category_id])
    # @questions = @sub_category.answered_questions_list(current_user.id).page(params[:page]).per(10)
    # @question = Question.new
    # render :show
  end

  def update
    # get_category
    # @sub_category = SubCategory.find_by_id(params[:id])
    # @sub_category.update(sub_category_params) if @sub_category
    # render :show
  end

  def delete
    # SubCategory.find_by_id(params[:id]).destroy!
  end

  private

    def load_course
      @course = Course.find(params[:course_id])
    #   @test = Test.find(params[:test_id])
    #   @course_user = CourseUser.where(course: @course, user: current_user).first if @course && @test
    end

    # def set_course_user_test
    #   @course_user_test = CourseUserTest.where(course_user: @course_user, test: @test).first # :opened or :paused
    # end

    # def course_user_test_params
    #   params.require(:course_user_test).permit(:course_user_id, :test_id, :action_form, :question_ids => [])
    # end
    # def sub_category_params
    #   params.require(:sub_category).permit(:name)
    # end

    def set_data
      @sub_category = SubCategory.find_by_id(params[:id])
      @questions = @sub_category.questions.where(parent_id:nil)
    end

end
