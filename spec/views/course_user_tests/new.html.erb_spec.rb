require 'rails_helper'

RSpec.describe "course_user_tests/new", type: :view do
  before(:each) do
    assign(:course_user_test, CourseUserTest.new(
      :course_user_id => 1,
      :test_id => 1
    ))
  end

  it "renders new course_user_test form" do
    render

    assert_select "form[action=?][method=?]", course_user_tests_path, "post" do

      assert_select "input#course_user_test_course_user_id[name=?]", "course_user_test[course_user_id]"

      assert_select "input#course_user_test_test_id[name=?]", "course_user_test[test_id]"
    end
  end
end
