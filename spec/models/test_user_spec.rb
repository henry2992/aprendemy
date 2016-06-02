require 'rails_helper'

RSpec.describe TestUser, type: :model do
  before :each do
    @test_user = FactoryGirl.build(:test_user)
  end

  it 'should not be valid without a test' do
    @test_user.test = nil
    expect(@test_user).to be_invalid
  end

  it 'should not be valid without a user' do
    @test_user.user = nil
    expect(@test_user).to be_invalid
  end

end
