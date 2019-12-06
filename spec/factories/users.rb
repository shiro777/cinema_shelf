FactoryBot.define do
  factory :user do
    name 'Hideaki Shirahama'
    sequence(:email) { |n| "shirahama#{n}@example.com" }
    password 'test_password'
    password_confirmation 'test_password'
  end
end
