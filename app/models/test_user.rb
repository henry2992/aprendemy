class TestUser < ActiveRecord::Base
  belongs_to :test
  belongs_to :user
  
  validates :test, :presence => true
  validates :user, :presence => true

  validates_associated :test, :user
end
