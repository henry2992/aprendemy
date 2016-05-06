class Section < ActiveRecord::Base
  belongs_to :course
  has_many :resources, :as => :material
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :course, :presence => true
end
