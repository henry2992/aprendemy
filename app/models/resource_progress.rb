class ResourceProgress < ActiveRecord::Base
  belongs_to :course_user
  belongs_to :section
  belongs_to :resource
  validates_associated :course_user, :section, :resource
end
