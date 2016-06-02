FactoryGirl.define do
  factory :test_user do
    test_id 1
    association :user, :factory => :user
  end
end
