require 'rails_helper'

describe LiveClass do
	before :each do
		@liveclass = FactoryGirl.build(:live_class)
	end

	it 'should not be valid without a subject' do
		@liveclass.subject = nil
		expect(@liveclass).to be_invalid
	end

	it 'should not be valid without a professor' do
		@liveclass.professor = nil
		expect(@liveclass).to be_invalid
	end

	it 'should not be valid without a url' do
		@liveclass.url = nil
		expect(@liveclass).to be_invalid
	end

	it 'should not be valid without a online_now' do
		@liveclass.online_now = nil
		expect(@liveclass).to be_invalid
	end

	it 'should not be valid without a time' do
		@liveclass.time = nil
		expect(@liveclass).to be_invalid
	end
	
	it 'should not be valid without a explanation' do
		@liveclass.explanation = nil
		expect(@liveclass).to be_invalid
	end

	it 'should not be valid without a course' do
		@liveclass.course_id = nil
		expect(@liveclass).to be_invalid
	end

end