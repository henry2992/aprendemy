require 'rails_helper'

RSpec.describe Blog, type: :model do
  before :each do
    @blog = FactoryGirl.build(:blog)
  end
  it 'should not be valid without a title' do
    @blog.title = nil
    expect(@blog).to be_invalid
  end
  it 'should not be valid without a content' do
    @blog.content = nil
    expect(@blog).to be_invalid
  end
end
