json.array!(@student_course_user_tests) do |student_course_user_test|
  json.extract! student_course_user_test, :id, :course_user_id, :test_id
  json.url student_course_user_test_url(student_course_user_test, format: :json)
end
