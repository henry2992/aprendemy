FactoryGirl.define do
  factory :course do
    name Faker::Name.name
    description Faker::Lorem.sentence
  end
end
