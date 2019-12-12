# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    sequence(:email) { |n| "user_#{n}@test.com" }
    password { "user_password" }
    password_confirmation { "user_password" }
    admin { false }
    activated { true }
    activated_at { Time.zone.now }

    trait :admin do
      admin { true }
    end

    trait :not_activated do
      activated { false }
      activated_at { nil }
    end
  end

  factory :other_user, class: "User" do
    sequence(:name) { |n| "other_user_#{n}" }
    sequence(:email) { |n| "other_user_#{n}@test.com" }
    password { "other_user_password" }
    password_confirmation { "other_user_password" }
    activated { true }
    activated_at { Time.zone.now }

    trait :not_activated do
      activated { false }
      activated_at { nil }
    end
  end
end
