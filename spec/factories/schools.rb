FactoryGirl.define do
  factory :school do
    name Faker::Name.name
    description Faker::Lorem.paragraph(2)
    image Faker::Company.logo
  end
end
