class Test < ActiveRecord::Base
  has_many :questions, -> { order('id') }, :as => :parent
  has_many :answers, :as => :item

  has_many :course_user_test, dependent: :destroy
  belongs_to :course

  # Picture Uploader
  mount_uploader :picture, PictureUploader

  validates :title, :presence => true, :length => { :minimum => 2 }
  validates :time_limit, presence: true, 
                         numericality: { 
                                only_integer: true, 
                                greater_than_or_equal_to: 15, 
                                less_than_or_equal_to: 120 
                              }
end
