class SubcategoryController < ApplicationController


  def start
    @subcategory = params[:id]
    redirect_to :action => "question"
  end


  def question

    @user = current_user

    @answered_questions = @user.answers.count

    id =  params[:id]

    @total = Subcategory.where(:id => id).count

    @subcategory = Subcategory.find_by_id(id)
    
    @subcategory.questions.each do |question|
      @question = question    
    end

    
    
  end

  def answer
   
     choiceid = params[:choice]
     
     @choice = choiceid ? Choice.find(choiceid) : nil
     
     if @choice and @choice.correct
        @correct = true
     else
        @correct = false
     end



  end
   
   
  
  def show
    @subcategory = Subcategory.find(params[:id])
  	@questions =  @subcategory.questions
  end



end
