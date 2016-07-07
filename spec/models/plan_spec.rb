require 'rails_helper'

RSpec.describe Plan, type: :model do
  before :each do
    @plan = FactoryGirl.build(:plan)
  end

  it 'should not be valid without a name' do
    @plan.name = nil
    expect(@plan).to be_invalid
  end
  it 'should not be valid without a expiration_days' do
    @plan.expiration_days = nil
    expect(@plan).to be_invalid
  end
  it 'should not be valid without a licence_type' do
    @plan.licence_type = nil
    expect(@plan).to be_invalid
  end
  it 'should not be valid without a price' do
    @plan.price = nil
    expect(@plan).to be_invalid
  end

end
