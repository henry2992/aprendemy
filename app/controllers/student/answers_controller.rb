class Student::AnswersController < Student::StudentController
  before_action :set_data

  def create
    @answer = current_user.answers.new(answer_params)
    @answer.item = nil
    respond_to do |format|
      if @answer.save
        format.html { redirect_to student_course_category_sub_category_path(@course,@category,@sub_category), notice: 'Answer was successfully created.' }
      else
        format.html { redirect_to student_course_category_sub_category_path(@course,@category,@sub_category), notice: 'Answer was not created.' }
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
