class Area < ActiveRecord::Base
  has_many :area_questions
  has_many :questions, through: :area_questions
end
