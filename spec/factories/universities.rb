FactoryGirl.define do
  factory :university do
    name Faker::University.name
    province Faker::Address.street_name
    city Faker::Address.city
    website Faker::Internet.url
    logo Faker::Company.logo
    type Faker::Number.between(0, 1)
  end
end
