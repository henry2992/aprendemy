require 'rails_helper'

RSpec.describe Resource, type: :model do

  before :each do
    @resource = FactoryGirl.build(:resource)
  end

  it 'should not be valid without a generic_name' do
    @resource.generic_name = nil
    expect(@resource).to be_invalid
  end

  it 'should not be valid without a material' do
    @resource.material = nil
    expect(@resource).to be_invalid
  end

  # it 'should not be valid without a section and tutorial' do
  #   blog = Blog.create(
  #                 title: Faker::Lorem.sentence(2, true, 2), 
  #                 content: Faker::Lorem.paragraph(2, true)
  #               )
  #   @resource.generic_name = Faker::Lorem.sentence(2, true, 2)
  #   @resource.tutorial_id = nil
  #   @resource.section_id = nil
  #   @resource.material = blog

  #   expect(@resource).to be_invalid
  # end

  it 'must be valid with an associated blog' do
    blog = Blog.create(
                  title: Faker::Lorem.sentence(2, true, 2), 
                  content: Faker::Lorem.paragraph(2, true)
                )
    @resource.generic_name = Faker::Lorem.sentence(2, true, 2)
    @resource.tutorial_id = 1
    @resource.material = blog
    expect(@resource).to be_valid
  end
  
  it 'must be valid with an associated task' do
    task = Task.create(
                  title: Faker::Lorem.sentence(2, true, 2), 
                  description: Faker::Lorem.paragraph(2, true)
                )
    @resource.generic_name = Faker::Lorem.sentence(2, true, 2)
    @resource.tutorial_id = 1
    @resource.material = task
    expect(@resource).to be_valid
  end

  it 'must be valid with an associated video' do
    video = Video.create(
                  name: Faker::Lorem.sentence(2, true, 2), 
                  description: Faker::Lorem.paragraph(2, true),
                  url: Faker::Internet.url
                )
    @resource.generic_name = Faker::Lorem.sentence(2, true, 2)
    @resource.tutorial_id = 1
    @resource.material = video
    expect(@resource).to be_valid
  end
end
