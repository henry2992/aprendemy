class Choice < ActiveRecord::Base
  belongs_to :question

  has_many :answers

  after_destroy :update_default_choice

  def update_default_choice
    self.question.update_attribute(:choice_id, nil) if self.question.choice_id == self.id
  end
end
