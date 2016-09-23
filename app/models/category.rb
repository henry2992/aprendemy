class Category < ActiveRecord::Base
  has_many :sub_categories, counter_cache: true
  has_many :answers, through: :sub_categories
  has_many :questions, through: :sub_categories

  belongs_to :course
  
  def question_count
    self.sub_categories.map { |s| s.questions.where(parent_id:nil).length }.inject(0, :+)
  end
  
  def subcategories_statistics
    self.sub_categories.map { |s| [s.name, "correct" => s.correct_answers, "total" => s.total_answers] }
  end
end
