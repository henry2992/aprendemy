require 'rails_helper'

RSpec.describe User do

  before :each do
    @user = FactoryGirl.build(:user)
  end

  it 'should not be valid without a first_name' do
    @user.first_name = nil
    expect(@user).to be_invalid
  end

  it 'should not be valid with without' do
    @user.last_name = nil
    expect(@user).to be_invalid
  end

end
