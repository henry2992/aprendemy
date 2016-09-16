class Section < ActiveRecord::Base
  belongs_to :course
  has_many :resources
  has_many :resource_progresses
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :course, :presence => true

  def top_position
    self.resources.map(&:position).max
  end
end
