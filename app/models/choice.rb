class Choice < ActiveRecord::Base
  belongs_to :question, dependent: :destroy

  has_many :answers
end
