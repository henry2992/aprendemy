FactoryGirl.define do
  factory :tutorial do
    title Faker::Lorem.sentence(2, true, 2)
    description Faker::Lorem.paragraph(2, true)
  end
end
