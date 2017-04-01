class Backend::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?
  require "httparty"

  def index
  end

  def update_image
    j = User.find_by_email("bjohnmer@hotmail.com")

    f = []

    # (1..2).each do |i|

    # Getting the file
    url = j.image.url
    file_name = url.split("/").last
    File.open("tmp/#{file_name}", "wb") do |f| 
      f.write HTTParty.get(url).body
    end
    f.push(file_name)

    # Updating record
    file = File.open("tmp/#{file_name}")
    j.update_attribute :image, file
    File.delete("tmp/#{file_name}")
      
    # end
    render json: f, status: 200
  end

  def test_upload
    file = File.open("public/1.jpg")
    School.create! name: "Nueva escuela", description: "descripción", image: file
    File.delete("public/1.jpg")
    render json: "ok", status: 200
  end
end
