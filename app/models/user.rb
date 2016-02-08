class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :categories, counter_cache: true
  has_many :sub_categories
  has_many :questions
  has_many :simulators
  has_many :simulator_question_and_answers

  has_one :user_role

  def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		  user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
	  end
	end

  def is_admin?
    self.user_role.role == 'admin' if self.user_role
  end
end
