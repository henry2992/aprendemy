FactoryGirl.define do
  factory :course_user_plan do
    course_user_id 1
    plan_id 1
    expiration_date Faker::Date.forward([10,30].shuffle.take(1)[0])
    status [0,1].shuffle.take(1)[0]
  end
end