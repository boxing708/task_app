FactoryBot.define do
  factory :user do
    name { "Naoya" }
    sequence(:email) { |n| "naoya#{n}@naoya.com" }
    password { "naoya0305" }
    password_confirmation { "naoya0305" }
  end
end
