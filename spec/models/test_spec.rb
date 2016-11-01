require 'rails_helper'

RSpec.describe Test do
	before :each do
		@test = FactoryGirl.build(:test)
	end

	it 'should not be valid without a title' do
		@test.title = nil
		expect(@test).to be_invalid
	end

	it 'should not be valid without a time_limit' do
		@test.time_limit = nil
		expect(@test).to be_invalid
	end

	it 'should not be valid if time_limit is not numeric' do
		@test.time_limit = "anything text"
		expect(@test).to be_invalid
	end

	it 'should not be valid if time_limit is less than 15' do
		@test.time_limit = 14
		expect(@test).to be_invalid
	end
	
	it 'should not be valid if time_limit is greater than 120' do
		@test.time_limit = 121
		expect(@test).to be_invalid
	end

end