module AnsweredQuestionsHelper

  def get_answered_question model, question_id
     model.find_by(user_id: current_user.id, question_id: question_id) || AnsweredQuestion.new
  end

  def correct_or_wrong question, choice, answered_question, was_selected
    ( (was_selected ? (answered_question.correct ? "correct" : "wrong") : ("correct" if choice.id == question.choice_id )) if answered_question.choice_id) || ""
  end

  def right_answer? question, choice, answered_question, was_selected
    ( (was_selected ? answered_question.status : ("correct" if choice.id == question.choice_id )) unless answered_question.unanswered?) || ""
  end
end
