class Student::AnswersController < Student::StudentController
  before_filter :check_plan, only: [:index]
  before_action :set_data

  def create
    respond_to do |format|
      if !current_user.answers.where(answer_params).any?
        @answer = current_user.answers.new(answer_params)
        @answer.item = nil
        if @answer.save
          format.html { redirect_to student_course_category_sub_category_path(@course,@category,@sub_category), notice: 'Answer was successfully created.' }
          format.json { render json: { "is_correct": @answer.is_correct?, "already_answered": false }, status: :created }
        else
          format.html { redirect_to student_course_category_sub_category_path(@course,@category,@sub_category), notice: 'Answer was not created.' }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to student_course_category_sub_category_path(@course,@category,@sub_category), notice: 'Answer was already created.' }
        format.json { render json: { "is_correct": false, "already_answered": true }, status: :unprocessable_entity }
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:question_id, :choice_id)
  end

  def set_data
    @category = Category.find(params[:category_id])
    @sub_category = SubCategory.find(params[:sub_category_id])
    @course = Course.find(params[:course_id])
  end

end
