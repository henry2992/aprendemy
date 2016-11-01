json.array!(@universities) do |university|
  json.extract! university, :id, :name, :province, :city, :website, :logo, :type
  json.url university_url(university, format: :json)
end
