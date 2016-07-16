class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :presence => true, :length => { :minimum => 2 }
  validates :last_name, :presence => true, :length => { :minimum => 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]
  after_create :create_license
  after_create :create_courses_by_default

  enum role: [:free, :paid, :admin]

  mount_uploader :image, UserUploader

  has_many :categories, counter_cache: true
  has_many :sub_categories
  has_many :questions
  has_many :simulators
  has_many :answered_questions
  has_many :simulator_answered_questions

  has_many :course_users, :dependent => :destroy
  has_many :courses, :through => :course_users

  has_many :answers
  
  has_one :license

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

  def points
    Point.where(recipient_id: self.id, recipient_type: 'User').sum(:points)
  end

  def create_license
    License.create(user: self) unless self.admin?
  end

  def create_courses_by_default
    Course.all.each{|c| CourseUser.create course_id: c.id, user_id: self.id}
  end
end