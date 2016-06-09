require 'rails_helper'

RSpec.describe "Student::CourseUserTests", type: :request do
  describe "GET /student_course_user_tests" do
    it "works! (now write some real specs)" do
      get student_course_user_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
