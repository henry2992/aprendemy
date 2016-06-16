require 'rails_helper'

RSpec.describe "student/course_user_tests/edit", type: :view do
  before(:each) do
    @student_course_user_test = assign(:student_course_user_test, Student::CourseUserTest.create!(
      :course_user_id => 1,
      :test_id => 1
    ))
  end

  it "renders the edit student_course_user_test form" do
    render

    assert_select "form[action=?][method=?]", student_course_user_test_path(@student_course_user_test), "post" do

      assert_select "input#student_course_user_test_course_user_id[name=?]", "student_course_user_test[course_user_id]"

      assert_select "input#student_course_user_test_test_id[name=?]", "student_course_user_test[test_id]"
    end
  end
end
