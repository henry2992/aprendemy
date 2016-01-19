module AnsweredQuestionsHelper

  def get_answered_question question_id
     AnsweredQuestion.find_by(user_id: current_user.id, question_id: question_id) || AnsweredQuestion.new
  end

  def correct_or_wrong answered_question
    ((answered_question.correct ? "correct" : "wrong") if answered_question.id) || ""
  end

end
