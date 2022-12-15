FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    date_of_birth { Faker::Date.birthday(min_age: 10) }
    password { Faker::Internet.password }
    confirmed_at { Time.now }
    location { 0 }
    # create an num for the rule
    rule { 0 }
  end

  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
  end

  factory :purchase do
    association :user, factory: :user
    association :product, factory: :product
    price { Faker::Commerce.price }
  end

  factory :point do
    point { Faker::Number.number(digits: 3) }
    association :user, factory: :user
  end

  factory :reward do
    reward_type { "Coffee" }
    association :user, factory: :user
  end
end
