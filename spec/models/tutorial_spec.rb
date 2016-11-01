require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  before :each do
    @tutorial = FactoryGirl.build(:tutorial)
  end

  it 'should not be valid without a title' do
    @tutorial.title = nil
    expect(@tutorial).to be_invalid
  end

  it 'should not be valid without a description' do
    @tutorial.description = nil
    expect(@tutorial).to be_invalid
  end
end
