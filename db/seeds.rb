# frozen_string_literal: true

User.create!(name: "shiro777",
             email: "hideaki.shirahama@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do
  Faker::Config.locale = :ja
  name = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  Faker::Config.locale = :en
  image = Faker::Avatar.image
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               image: image,
               activated: true,
               activated_at: Time.zone.now)
end
