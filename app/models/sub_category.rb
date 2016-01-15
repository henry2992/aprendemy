class SubCategory < ActiveRecord::Base
  belongs_to :category
  has_many :questions
  has_many :answered_questions, through: :questions
  has_many :choices, through: :questions


end
