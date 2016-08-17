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

  def plan_days_left
    (self.course_users.find_by(user: User.current).course_user_plan.expiration_date - Date.today).to_i
  end

  def question_count
    self.categories.map {|c| c.sub_categories.map { |s| s.questions.count }.inject(0, :+)}.inject(0, :+)
  end
end
