class Question < ActiveRecord::Base
  has_many :choices
  has_many :answered_questions
  has_many :simulator_question_and_answers
  belongs_to :user
  belongs_to :sub_categories, counter_cache: true

  mount_uploader :picture, PictureUploader

end
