FactoryGirl.define do
  factory :test do
    title Faker::Lorem.sentence(2, true, 2)
    description Faker::Lorem.paragraph(2, true)
    time_limit 0
  end
end
