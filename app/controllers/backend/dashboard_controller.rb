class Backend::DashboardController < ApplicationController
  before_filter :authenticate_user!
  before_filter :user_is_admin?
  require "httparty"

  def index
  end

  def update_image

    courses = Test.all

    fn = []

    courses.each do |x|

      if x.picture.url

        # Getting the file
        url = x.picture.url.sub("www-aprendemy-com", "drkw6qcjz")

        puts url
        file_name = url.split("/").last
        
        puts file_name
        f = File.open("/tmp/#{file_name}", "wb")
        f.write HTTParty.get(url).body
        
        fn.push(file_name)

        # Updating record
        file = File.open("/tmp/#{file_name}")

        puts file
        x.update_attribute :picture, file if file.size > 0
        
        File.delete("/tmp/#{file_name}")
      end
    end

    render json: fn, status: 200
  end

end
