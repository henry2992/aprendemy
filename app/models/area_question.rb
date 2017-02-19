class AreaQuestion < ActiveRecord::Base
  belongs_to :area
  belongs_to :question
  validates_presence_of :area, :question
end
