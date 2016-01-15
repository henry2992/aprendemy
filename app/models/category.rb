class Category < ActiveRecord::Base
  has_many :sub_categories
  has_many :questions, through: :sub_categories
  belongs_to :user
end
