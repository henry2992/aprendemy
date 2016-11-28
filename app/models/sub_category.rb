class SubCategory < ActiveRecord::Base   
  belongs_to :category, counter_cache: true
  has_many :questions
  has_many :choices, through: :questions
  has_many :answers, through: :questions
  has_many :tutorials
  has_many :video_classes

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  def question_count
    self.questions.length
  end

  def correct_answers user = nil
    answers = self.answers.where.not(question_id: Test.where(test_type: 1).map { |t| t.questions.map(&:id) }.flatten)
    # answers = answers.where() if course
    answers = answers.where.not(user: user) if user
    answers.map{ |a| a.is_correct? }.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }[true]
  end
  
  def wrong_answers user = nil
    answers = self.answers.where.not(question_id: Test.where(test_type: 1).map { |t| t.questions.map(&:id) }.flatten)
    answers = answers.where.not(user: user) if user
    answers.map{ |a| a.is_correct? }.each_with_object(Hash.new(0)) { |o, h| h[o] += 1 }[false]
  end

  def total_answers user = nil
    answers = self.answers.where.not(question_id: Test.where(test_type: 1).map { |t| t.questions.map(&:id) }.flatten)
    answers = answers.where.not(user: user) if user
    answers.length
  end

  def points
    Point.where(recipient_id: self.id, recipient_type: 'SubCategory').sum(:points)
  end

end
