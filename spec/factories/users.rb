FactoryBot.define do
  factory :user do
    name 'Hideaki Shirahama'
    sequence(:email) { |n| "shirahama#{n}@example.com" }
    # password 'test-password'
  end
end
