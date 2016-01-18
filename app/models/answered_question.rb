class AnsweredQuestion < ActiveRecord::Base
  belongs_to :question, counter_cache: true
  belongs_to :user

  has_many :choices, through: :question
end
