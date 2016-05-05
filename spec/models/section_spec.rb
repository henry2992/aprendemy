require 'rails_helper'

RSpec.describe Section, type: :model do
  before :each do
    @section = FactoryGirl.build(:section)
  end
  it 'should not be valid without a name' do
    @section.name = nil
    expect(@section).to be_invalid
  end
  it 'should not be valid without a course' do
    @section.course = nil
    expect(@section).to be_invalid
  end
end
