FactoryBot.define do
  factory :user do
    name 'user'
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'user_password'
    password_confirmation 'user_password'
  end

  factory :other_user, class: User do
    name 'other_user'
    sequence(:email) { |n| "other_user#{n}@example.com" }
    password 'other_user_password'
    password_confirmation 'other_user_password'
  end
end
