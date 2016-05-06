class Task < ActiveRecord::Base
  has_one :resources, :as => :material
  has_many :questions
  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :description, :presence => true, :length => { :minimum => 2 }
end
