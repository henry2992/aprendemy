class ChoicesController < ApplicationController

    def index
      get_category_and_sub_and_question && @choices = @choices.all
    end

    def new
      get_category_and_sub_and_question && @choice = Choice.new
    end

    def create
      get_category_and_sub_and_question
      @choice = @question.choices.create(choice_params.except(:is_answer))
      if @choice
        update_if_correct_choice
        flash[:success] = "New question has been created successfully"
      else
        flash[:danger] = "An error occured. Please try again."
      end
      show_choices_index
    end

    def edit
      get_category_and_sub_and_question && @choice = Choice.find_by_id(params[:id])
      render :new
    end

    def show
      get_category_and_sub_and_question && @choice = Choice.find_by_id(params[:id])
    end

    def update
      get_category_and_sub_and_question
      @choice = Choice.find_by_id(params[:id])
      @choice.update(choice_params) if @choice
      update_if_correct_choice
      show_choices_index
    end

    def delete
      Question.find_by_id(params[:id]).destroy!
      flash[:notice] = "Question has been deleted successfully"
      show_questions_index
    end

    private

    def choice_params
      params.require(:choice).permit(:content)
    end

    def get_category_and_sub_and_question
      @category = Category.find_by_id(params[:category_id])
      @sub_category = SubCategory.find_by_id(params[:sub_category_id])
      @question = Question.find_by_id(params[:question_id])
    end

    def show_choices_index
      redirect_to category_sub_category_question_choice_path(@category, @sub_category, @question, @choice)
    end

    def update_if_correct_choice
      @question.update(choice_id: @choice.id) if params[:correct_choice] == "1"
    end
end
