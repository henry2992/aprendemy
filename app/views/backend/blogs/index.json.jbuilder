json.array!(@blogs) do |blog|
  json.extract! blog, :id, :title, :content
  json.url backend_blog_url(blog, format: :json)
end
