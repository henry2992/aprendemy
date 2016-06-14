json.array!(@course_user_tests) do |course_user_test|
  json.extract! course_user_test, :id, :course_user_id, :test_id
  json.url course_user_test_url(course_user_test, format: :json)
end
