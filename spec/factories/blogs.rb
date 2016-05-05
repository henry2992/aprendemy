FactoryGirl.define do
  factory :blog do
    title Faker::Lorem.sentence(2, true, 2)
    content Faker::Lorem.paragraph(2, true)
  end
end