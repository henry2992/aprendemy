class Plan < ActiveRecord::Base

  has_many :course_user_plans
  has_many :course_users, through: :course_user_plans
  
  enum licence_type: [:free,:paid]

  validates_presence_of :name, :expiration_days, :licence_type, :price

end
