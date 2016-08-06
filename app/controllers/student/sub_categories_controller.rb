class Student::SubCategoriesController < Student::StudentController

  before_filter :check_plan, only: [:index]
  
  def show
      @course = Course.find(params[:course_id])
      @sub_category = SubCategory.find_by_id(params[:id])
      page_questions = params[:page] if params[:paginate] == "q"
      page_answered = params[:page] if params[:paginate] == "a"


      @questions = @sub_category.questions.where(parent_id:nil).where.not(id: Answer.where(user: current_user).map(&:question_id)).paginate(:page => page_questions, :per_page => 1)
      @answered = @sub_category.questions.where(parent_id:nil).where(id: Answer.where(user: current_user).map(&:question_id)).paginate(:page => page_answered, :per_page => 20)
  end
end
