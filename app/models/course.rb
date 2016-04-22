class Course < ActiveRecord::Base
  has_many :categories
  has_many :tutorials
  has_many :course_users, :dependent => :destroy
  has_many :users, :through => :course_users
  validates :name, :description, presence: true
end
