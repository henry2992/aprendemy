require 'rails_helper'

RSpec.describe "CourseUserTests", type: :request do
  describe "GET /course_user_tests" do
    it "works! (now write some real specs)" do
      get course_user_tests_path
      expect(response).to have_http_status(200)
    end
  end
end
