json.extract! backend_course, :id, :name, :description, :author, :picture, :created_at, :updated_at
json.url backend_course_url(backend_course, format: :json)