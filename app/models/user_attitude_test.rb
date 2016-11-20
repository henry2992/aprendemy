class UserAttitudeTest < ActiveRecord::Base
  belongs_to :user
  belongs_to :test

  validates_presence_of :user, :test
end
