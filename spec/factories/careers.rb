FactoryGirl.define do
    
  factory :career do
    name Faker::Name.name
    description Faker::Lorem.paragraph(2, true)
    image Faker::Company.logo
    faculty "Data lorem"
    association :school, :factory => :school
    type 1
    association :university, :factory => :university
  end
end
