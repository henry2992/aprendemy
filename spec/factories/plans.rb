FactoryGirl.define do
  factory :plan do
    name Faker::Commerce.product_name
    description Faker::Lorem.paragraph(5, true)
    expiration_days [10,30].shuffle.take(1)[0]
    licence_type [0,1].shuffle.take(1)[0]
    price Faker::Commerce.price
  end
end