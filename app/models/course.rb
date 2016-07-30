class Course < ActiveRecord::Base
  has_many :categories
  has_many :sections

  has_many :course_users, :dependent => :destroy
  has_many :users, :through => :course_users

  has_many :tests
  has_one :live_class
  
  # Validations
  validates :name, :description, presence: true

  # Picture Uploader
  mount_uploader :picture, PictureUploader

end
