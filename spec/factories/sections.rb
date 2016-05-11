FactoryGirl.define do
  factory :section do
    name Faker::Lorem.sentence(2, true, 2)
    association :course, :factory => :course
  end
end
