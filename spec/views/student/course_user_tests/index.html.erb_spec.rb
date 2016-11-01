require 'rails_helper'

RSpec.describe "student/course_user_tests/index", type: :view do
  before(:each) do
    assign(:student_course_user_tests, [
      Student::CourseUserTest.create!(
        :course_user_id => 1,
        :test_id => 2
      ),
      Student::CourseUserTest.create!(
        :course_user_id => 1,
        :test_id => 2
      )
    ])
  end

  it "renders a list of student/course_user_tests" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
