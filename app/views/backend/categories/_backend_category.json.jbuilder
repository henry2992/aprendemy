json.extract! backend_category, :id, :name, :sub_categories_count, :created_at, :updated_at
json.url backend_category_url(backend_category, format: :json)