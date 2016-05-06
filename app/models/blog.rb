class Blog < ActiveRecord::Base
  has_one :resource, :as => :material
  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :content, :presence => true, :length => { :minimum => 2 }
end
