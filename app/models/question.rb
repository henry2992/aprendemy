class Question < ActiveRecord::Base
  has_many :answers
  has_many :choices

  belongs_to :sub_category, counter_cache: true

  # now one question must belongs to Task, Simulator or Test
  belongs_to :parent, :polymorphic => true

  # Self relation
  # Add capability to have multiple questions - https://app.asana.com/0/107597944834039/116471366670689
  has_many :questions, class_name: "Question", foreign_key: "question_id"
  belongs_to :question, class_name: "Question"

  mount_uploader :picture, PictureUploader

  # scope :avergage_time, -> (object) { where( object[:field].to_s.html_safe + " like ? ","%#{object[:textsearch].to_s.html_safe}%")}

end
