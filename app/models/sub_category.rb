class SubCategory < ActiveRecord::Base   
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :answers, through: :questions
  has_many :tutorials

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  def question_count
    self.questions.where(parent_id:nil).length
  end

  def correct_answers
    self.answers.map{ |a| a.is_correct? }.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }[true]
  end
  
  def wrong_answers
    self.answers.map{ |a| a.is_correct? }.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }[false]
  end

  def total_answers
    self.answers.length
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'SubCategory').sum(:points)
  end

end
