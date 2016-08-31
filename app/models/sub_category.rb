class SubCategory < ActiveRecord::Base
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :tutorials

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  def question_count
    self.questions.where(parent_id:nil).length
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'SubCategory').sum(:points)
  end

end
