require 'rails_helper'

RSpec.describe CourseUserPlan, type: :model do
  before :each do
    @course_user_plan = FactoryGirl.build(:course_user_plan)
  end

  it 'should not be valid without a course_user and plan' do
    @course_user_plan.course_user_id = nil
    @course_user_plan.plan_id = nil
    expect(@course_user_plan).to be_invalid
  end

end
