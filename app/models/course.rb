class Course < ActiveRecord::Base
  has_many :categories
  has_many :tutorials
end
