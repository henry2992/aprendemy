FactoryGirl.define do
  factory :section do
    name Faker::Lorem.sentence(2, true, 2)
    association :course, :factory => :course
    # association :resource, :factory => :resource
  end
end
