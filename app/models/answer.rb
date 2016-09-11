class Answer < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :question
  belongs_to :user
  belongs_to :choice

  after_save :add_to_statistics

  def is_correct?
    self.question.choice_id == self.choice_id ? true : false
  end

  # SubCategory.find(44).answers.map{ |a| a.is_correct? }
  def add_to_statistics
    add1q = self.question
    add1c = self.choice
    add1q.total_answered_count += 1
    add1c.total_answered_count += 1
    # if self.choice_id != add1q.choice_id
    if !self.is_correct?
      add1q.wrong_answered_count += 1
      add1c.wrong_answered_count += 1
    end
    add1q.save
    add1c.save
  end

end