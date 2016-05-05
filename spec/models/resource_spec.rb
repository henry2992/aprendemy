require 'rails_helper'

RSpec.describe Resource, type: :model do
  before :each do
    @resource = FactoryGirl.build(:resource)
  end

  it 'should not be valid without a generic_name' do
    @resource.generic_name = nil
    expect(@resource).to be_invalid
  end
end
