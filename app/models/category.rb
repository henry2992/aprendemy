class Category < ActiveRecord::Base
  has_many :sub_categories, counter_cache: true
  has_many :questions, through: :sub_categories

  belongs_to :course
  
  def question_count
    self.sub_categories.map { |s| s.questions.length }.inject(0, :+)
  end
end
