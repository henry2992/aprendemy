class Question < ActiveRecord::Base
	has_many :choices

	belongs_to :subcategory

	has_many :answers



	  
	
end
