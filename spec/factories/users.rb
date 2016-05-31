FactoryGirl.define do
  factory :user do
    first_name Faker::Name.name
    last_name  Faker::Name.last_name
    password "pass123"
    password_confirmation "pass123"
    email Faker::Internet.email
  end
end
