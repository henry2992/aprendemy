class Course < ActiveRecord::Base
  has_many :categories
  has_many :tutorials
  validates :name, :description, presence: true
end
