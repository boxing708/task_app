FactoryBot.define do
  factory :user do
    name { "Naoya" }
    email { "naoya@naoya.com" }
    password { "naoya0305" }
    password_confirmation { "naoya0305" }
  end
end
