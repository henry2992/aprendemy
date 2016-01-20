module AnsweredQuestionsHelper

  def get_answered_question question_id
     AnsweredQuestion.find_by(user_id: current_user.id, question_id: question_id) || AnsweredQuestion.new
  end

  def correct_or_wrong question, choice, answered_question, was_selected
    ( (was_selected ? (answered_question.correct ? "correct" : "wrong") : ("correct" if choice.id == question.choice_id )) if answered_question.id) || ""
  end

end
