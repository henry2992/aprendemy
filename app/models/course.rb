class Course < ActiveRecord::Base
  has_many :categories
end
