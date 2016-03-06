class Simulator < ActiveRecord::Base
  # serialize :question_ids, Array
  belongs_to :user, dependent: :destroy
  has_many :simulator_answered_questions
  has_many :questions, through: :simulator_answered_questions
  belongs_to :simulator_type, dependent: :destroy
  enum status: [:paused, :completed]

  answered = "Question.where('id in (?)', self.simulator_answered_questions.where.not(status: 'unanswered').pluck(:question_id))"
  correct = "self.questions.where(id: self.simulator_answered_questions.correct.pluck(:question_id))"
  incorrect = "self.questions.where(id: self.simulator_answered_questions.wrong.pluck(:question_id))"
  unanswered = "Question.where('id in (?)', self.simulator_answered_questions.unanswered.pluck(:question_id))"

  {questions_list: answered, correctly: correct, incorrectly: incorrect, not: unanswered}.each do |action, value|
    define_method("answered_#{action}") do |*args|
      process_filters(args) do |model_instance, condition|
        eval (condition.empty? ? value : "#{value}.where(#{condition})")
      end
    end
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'Simulator').sum(:points)
  end

  private

  def category_filter
    "'sub_category_id IN (?)', model_instance.sub_categories.pluck(:id)"
  end

  def sub_category_filter
    "sub_category_id: model_instance.id"
  end

  def process_filters args
    model_instance = nil; condition = ""
    unless args.empty? ||  args[0].nil?
      model = get_model args[0][:model]
      if model
        model_instance = model.find_by_id(args[0][:id])
        condition = send "#{args[0][:model]}_filter"
      end
    end
    yield(model_instance, condition) if block_given?
  end

  def get_model model_string
    begin
      model_string.camelize.constantize
    rescue
      false
    end
  end

end
