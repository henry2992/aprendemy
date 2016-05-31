FactoryGirl.define do
  factory :course_user do
    association :course, :factory => :course
    association :user, :factory => :user
  end
end
