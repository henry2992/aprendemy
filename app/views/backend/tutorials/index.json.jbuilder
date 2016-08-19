json.array!(@tutorials) do |tutorial|
  json.extract! tutorial, :id, :title, :description
  json.url tutorial_url(tutorial, format: :json)
end
