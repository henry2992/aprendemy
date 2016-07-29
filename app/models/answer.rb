class Answer < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :question
  belongs_to :user
  belongs_to :choice

  after_save :add_to_statistics

  def is_correct?
    self.question.choice_id == self.choice_id ? true : false
  end
  def add_to_statistics
    add1 = self.question
    add1.total_answered_count += 1
    if self.choice_id != add1.choice_id
      add1.wrong_answered_count += 1
    end
    add1.save
  end

end
