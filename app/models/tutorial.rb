class Tutorial < ActiveRecord::Base

	has_many :resources

  validates :title, :description, presence: true
end
