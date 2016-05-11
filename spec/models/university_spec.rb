require 'rails_helper'

RSpec.describe University do
	before :each do
		@university = FactoryGirl.build(:university)
	end

	it 'should not be valid without a name' do
		@university.name = nil
		expect(@university).to be_invalid
	end

	it 'should not be valid without a province' do
		@university.province = nil
		expect(@university).to be_invalid
	end

	it 'should not be valid without a city' do
		@university.city = nil
		expect(@university).to be_invalid
	end

	it 'should not be valid without a type' do
		@university.type = nil
		expect(@university).to be_invalid
	end

end