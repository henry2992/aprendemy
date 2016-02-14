class Question < ActiveRecord::Base
  has_many :choices
  has_many :answered_questions
  has_many :simulator_answered_questions
  belongs_to :user
  belongs_to :sub_category, counter_cache: true, dependent: :destroy

  mount_uploader :picture, PictureUploader

end
