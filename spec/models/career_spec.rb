require 'rails_helper'

describe Career do
	before :each do
		@career = FactoryGirl.build(:career)
	end

	it 'should not be valid without a name' do
		@career.name = nil
		expect(@career).to be_invalid
	end

	it 'should not be valid without a faculty' do
		@career.faculty = nil
		expect(@career).to be_invalid
	end

	it 'should not be valid without a school' do
		@career.school = nil
		expect(@career).to be_invalid
	end

	it 'should not be valid without a type' do
		@career.type = nil
		expect(@career).to be_invalid
	end

	it 'should not be valid without a university' do
		@career.university = nil
		expect(@career).to be_invalid
	end

end