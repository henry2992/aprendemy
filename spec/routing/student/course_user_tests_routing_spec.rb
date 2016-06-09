require "rails_helper"

RSpec.describe Student::CourseUserTestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/student/course_user_tests").to route_to("student/course_user_tests#index")
    end

    it "routes to #new" do
      expect(:get => "/student/course_user_tests/new").to route_to("student/course_user_tests#new")
    end

    it "routes to #show" do
      expect(:get => "/student/course_user_tests/1").to route_to("student/course_user_tests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/student/course_user_tests/1/edit").to route_to("student/course_user_tests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/student/course_user_tests").to route_to("student/course_user_tests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/student/course_user_tests/1").to route_to("student/course_user_tests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/student/course_user_tests/1").to route_to("student/course_user_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/student/course_user_tests/1").to route_to("student/course_user_tests#destroy", :id => "1")
    end

  end
end
