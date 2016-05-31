# Helper for
# AnsweredQuestions
module AnsweredQuestionsHelper
  def get_answered_question(model, question_id)
    model.find_by(user_id: current_user.id, question_id: question_id) || model.new
  end

  def get_simulator_answered_question(model, simulator_id, question_id)
    model.find_by(user_id: current_user.id, question_id: question_id, simulator_id: simulator_id) || model.new
  end

  def correct_or_wrong(question, choice, answered_question, was_selected)
    ((was_selected ? (answered_question.correct ? "correct" : "wrong") : ("correct" if choice.id == question.choice_id)) if answered_question.choice_id) || ""
  end

  def right_answer?(question, choice, answered_question, was_selected)
    ((was_selected ? answered_question.status : ("correct" if choice.id == question.choice_id)) unless answered_question.unanswered?) || ""
  end

  def options
    ['A )', 'B )', 'C )', 'D )', 'E )']
  end

  def clue_status(answered, marked)
    # (answered ? 'answered' : (marked ? 'later' : ''))
    (marked ? 'later' : (answered ? 'answered' : ''))
  end

  def answered_question_meta(question_id, sub_question, count)
    {id: question_id, answered: !sub_question.unanswered?, marked: sub_question.marked?, serial_no: count}
  end
end
