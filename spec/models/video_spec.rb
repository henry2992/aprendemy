require 'rails_helper'

RSpec.describe Video, type: :model do
  before :each do
    @video = FactoryGirl.build(:video)
  end

  it 'should not be valid without a name' do
    @video.name = nil
    expect(@video).to be_invalid
  end

  it 'should not be valid without a description' do
    @video.description = nil
    expect(@video).to be_invalid
  end

  it 'should not be valid without a url' do
    @video.url = nil
    expect(@video).to be_invalid
  end
  
  it 'should not be valid if is not a valid url' do
    @video.url = Faker::Lorem.sentence(2, true, 2)
    expect(@video).to be_invalid
  end
end
