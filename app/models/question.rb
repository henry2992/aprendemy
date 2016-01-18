class Question < ActiveRecord::Base
  has_many :choices
  has_many :answered_questions
  belongs_to :user
  belongs_to :sub_categories, counter_cache: true

end
