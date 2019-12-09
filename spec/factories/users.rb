FactoryBot.define do
  factory :user do
    name 'user'
    sequence(:email) { |n| "user-#{n}@test.com" }
    password 'user_password'
    password_confirmation 'user_password'

    trait :admin do
      admin true
    end
  end

  factory :other_user, class: User do
    name 'other_user'
    sequence(:email) { |n| "other_user-#{n}@test.com" }
    password 'other_user_password'
    password_confirmation 'other_user_password'
  end
end
