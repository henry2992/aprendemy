require "rails_helper"

RSpec.describe CourseUserTestsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/course_user_tests").to route_to("course_user_tests#index")
    end

    it "routes to #new" do
      expect(:get => "/course_user_tests/new").to route_to("course_user_tests#new")
    end

    it "routes to #show" do
      expect(:get => "/course_user_tests/1").to route_to("course_user_tests#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/course_user_tests/1/edit").to route_to("course_user_tests#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/course_user_tests").to route_to("course_user_tests#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/course_user_tests/1").to route_to("course_user_tests#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/course_user_tests/1").to route_to("course_user_tests#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/course_user_tests/1").to route_to("course_user_tests#destroy", :id => "1")
    end

  end
end
