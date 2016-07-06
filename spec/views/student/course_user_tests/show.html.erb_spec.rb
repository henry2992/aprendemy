require 'rails_helper'

RSpec.describe "student/course_user_tests/show", type: :view do
  before(:each) do
    @student_course_user_test = assign(:student_course_user_test, Student::CourseUserTest.create!(
      :course_user_id => 1,
      :test_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
  end
end
