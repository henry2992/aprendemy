class SubCategory < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :tutorials

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  def points
    Point.where(recipient_id: self.id, recipient_type: 'SubCategory').sum(:points)
  end
end
