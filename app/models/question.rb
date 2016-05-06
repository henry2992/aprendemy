class Question < ActiveRecord::Base
  has_many :choices
  has_many :answered_questions
  has_many :simulator_answered_questions
  has_many :resources, :as => :material
  belongs_to :user
  belongs_to :task
  belongs_to :sub_category, counter_cache: true
  mount_uploader :picture, PictureUploader
end
