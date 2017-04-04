class Backend::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?
  require "httparty"

  def index
  end

  def update_image

    courses = Course.all

    f = []

    courses.each do |x|

      if x.picture.url

        # Getting the file
        url = x.picture.url

        puts url
        file_name = url.split("/").last
        
        puts file_name
        File.open("/tmp/#{file_name}", "wb") do |f| 
          f.write HTTParty.get(url).body
        end
        f.push(file_name)

        # Updating record
        file = File.open("/tmp/#{file_name}")

        puts file
        x.update_attribute :picture, file
        
        File.delete("/tmp/#{file_name}")
      end
    end

    render json: f, status: 200
  end

  # def test_upload
  #   file = File.open("public/1.jpg")
  #   School.create! name: "Nueva escuela", description: "descripción", image: file
  #   File.delete("public/1.jpg")
  #   render json: "ok", status: 200
  # end
end
