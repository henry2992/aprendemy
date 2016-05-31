FactoryGirl.define do
  factory :video do
    name Faker::Lorem.sentence(2, true, 2)
    description Faker::Lorem.paragraph(2, true)
    url Faker::Internet.url
  end
end
