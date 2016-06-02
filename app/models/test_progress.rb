class TestProgress < ActiveRecord::Base
  belongs_to :test_user
  belongs_to :question
  belongs_to :answer
  
  validates_presence_of :test_user, :question, :answer

  validates_associated :test_user, :question, :answer
end
