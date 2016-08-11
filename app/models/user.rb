class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :first_name, :presence => true, :length => { :minimum => 2 }
  validates :last_name, :presence => true, :length => { :minimum => 2 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  enum role: [:free, :paid, :admin]
  #self.inheritance_column = :_role_disabled
  mount_uploader :image, UserUploader

  has_many :course_users, :dependent => :destroy
  has_many :courses, :through => :course_users

  has_many :answers

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

  def self.current
    Thread.current[:user]
  end
  
  def self.current=(user)
    Thread.current[:user] = user
  end
end
