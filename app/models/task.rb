class Task < ActiveRecord::Base
  has_one :resource, :as => :material

  has_many :answers, :as => :item
  has_many :questions, :as => :parent 
  
  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :description, :presence => true, :length => { :minimum => 2 }
end
