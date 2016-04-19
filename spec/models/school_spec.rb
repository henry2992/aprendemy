require 'rails_helper'

describe School do
	before :each do
		@school = FactoryGirl.build(:school)
	end

	it 'should not be valid without a name' do
		@school.name = nil
		expect(@school).to be_invalid
	end

	it 'should not be valid without a description' do
		@school.description = nil
		expect(@school).to be_invalid
	end

end