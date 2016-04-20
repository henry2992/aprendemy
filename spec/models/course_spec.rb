require 'rails_helper'

RSpec.describe Course, type: :model do
  before :each do
    @course = FactoryGirl.build(:course)
  end

  it 'should not be valid without a name' do
    @course.name = nil
    expect(@course).to be_invalid
  end

  it 'should not be valid without description' do
    @course.name = "test"
    @course.description = nil
    expect(@course).to be_invalid
  end

end
