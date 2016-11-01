require 'rails_helper'

RSpec.describe Task, type: :model do
  before :each do
    @task = FactoryGirl.build(:task)
  end
  it 'should not be valid without a title' do
    @task.title = nil
    expect(@task).to be_invalid
  end
  it 'should not be valid without a description' do
    @task.description = nil
    expect(@task).to be_invalid
  end
end
