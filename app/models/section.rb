class Section < ActiveRecord::Base
  belongs_to :course
  has_many :resources, -> { order(:position, :created_at) }, :dependent => :destroy
  has_many :resource_progresses, :dependent => :destroy
  validates :name, :presence => true, :length => { :minimum => 2 }
  validates :course, :presence => true

  def top_position
    self.resources.map(&:position).max == nil ? 0 : self.resources.map(&:position).max
  end
end
