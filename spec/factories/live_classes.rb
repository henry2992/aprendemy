FactoryGirl.define do
  factory :live_class do
    subject Faker::Lorem.sentence(4)
    professor Faker::Name.name
    url Faker::Internet.url
    online_now Faker::Number.between(0, 1)
    time Faker::Time.between(DateTime.now - 1, DateTime.now)
    explanation Faker::Lorem.paragraph(3)
  end
end
