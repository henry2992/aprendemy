FactoryGirl.define do
  factory :resource do
    generic_name Faker::Lorem.sentence(2, true, 2)
    association :tutorial, :factory => :tutorial
  end
end
