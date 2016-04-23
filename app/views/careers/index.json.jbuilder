json.array!(@careers) do |career|
  json.extract! career, :id, :name, :description, :image, :faculty, :school, :type
  json.url career_url(career, format: :json)
end
