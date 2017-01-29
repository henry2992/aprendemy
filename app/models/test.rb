class Test < ActiveRecord::Base
  has_many :questions, -> { order('id') }, :as => :parent, dependent: :destroy
  has_many :answers, :as => :item, dependent: :destroy

  has_many :areas, :through => :questions
  
  has_many :course_user_test, dependent: :destroy
  belongs_to :course

  has_many :user_attitude_tests
  has_many :users, :through => :user_attitude_tests

  enum test_type: [:standard, :attitude]

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :time_limit, :allow_blank => true,
                          numericality: { 
                                only_integer: true, 
                                greater_than_or_equal_to: 15, 
                                less_than_or_equal_to: 120 
                              }
end
