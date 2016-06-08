class Test < ActiveRecord::Base
  has_many :questions, :as => :parent

  has_many :course_test_users
  belongs_to :course

  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :time_limit, :presence => true, 
                         numericality: { 
                                only_integer: true, 
                                greater_than_or_equal_to: 15, 
                                less_than_or_equal_to: 120 
                              }
  validates :total_questions, :presence => true, 
                              numericality: { 
                                only_integer: true, 
                                greater_than_or_equal_to: 5, 
                                less_than_or_equal_to: 10 
                              }
end
