class Student::SubCategoriesController < Student::StudentController

  before_filter :check_plan, only: [:index]
  
  def show
      @course = Course.find(params[:course_id])
      @sub_category = SubCategory.find_by_id(params[:id])
      page_questions = params[:page] if params[:paginate] == "q" && @sub_category.questions.where(parent_id:nil).where.not(id: Answer.where(user: current_user).map(&:question_id)).length > 1
      page_answered = params[:page] if params[:paginate] == "a" && @sub_category.questions.where(parent_id:nil).where(id: Answer.where(user: current_user).map(&:question_id)).length > 1

      @questions = @sub_category.questions.where(parent_id:nil).where.not(id: Answer.where(user: current_user).map(&:question_id)).paginate(:page => page_questions, :per_page => 5)
      @answered = @sub_category.questions.where(parent_id:nil).where(id: Answer.where(user: current_user).map(&:question_id)).paginate(:page => page_answered, :per_page => 5)
  end
end
