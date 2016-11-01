require 'rails_helper'

RSpec.describe CourseUser, type: :model do
  before :each do
    @course_user = FactoryGirl.build(:course_user)
  end

  it 'should not be valid without a course' do
    @course_user.course = nil
    expect(@course_user).to be_invalid
  end

  it 'should not be valid without a user' do
    @course_user.user = nil
    expect(@course_user).to be_invalid
  end
end
