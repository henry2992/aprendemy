class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :presence => true, :length => { :minimum => 2 }
  validates :last_name, :presence => true, :length => { :minimum => 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  enum role: %w(free paid admin psicologist)

  mount_uploader :image, UserUploader if Rails.env == "production"
  mount_uploader :image, PicUploader unless Rails.env == "production"

  has_many :course_users, :dependent => :destroy
  has_many :courses, :through => :course_users
  has_many :categories, -> { order(:id) }, :through => :courses
  has_many :sub_categories, :through => :categories
  has_many :answers, :through => :sub_categories

  has_many :user_attitude_tests
  has_many :tests, :through => :user_attitude_tests
  
  has_many :answers

  after_create :send_register_mail

  def statistics course = nil
    result = self
    result = self.courses.find(course) if course
    result.categories.preload(:answers,:questions,:sub_categories).map { |c| [c.name,c.sub_categories.map{ |sc| [sc.name,sc.correct_answers,sc.wrong_answers,sc.question_count, sc.id] },c.id]}
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      gender = auth.extra.raw_info.gender
      user.gender = if gender == 'male'
                      false
                    else
                      true
                    end
      user.remote_image_url = auth.info.image.gsub('http://','https://')
    end
  end

  def is_paid?
    self.course_users.map { |a| a.course_user_plan.plan.paid? }.count(true) > 0 ? true : false
  end

  def has_attitude_tests?
    self.user_attitude_tests.any?
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'User').sum(:points)
  end

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end

  def send_register_mail
    RegisterUser.send_mail(self).deliver
  end

end
