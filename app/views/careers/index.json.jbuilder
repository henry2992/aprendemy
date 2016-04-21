json.array!(@careers) do |career|
  json.extract! career, :id, :name, :description, :image, :website, :faculty, :school, :type
  json.url career_url(career, format: :json)
end
