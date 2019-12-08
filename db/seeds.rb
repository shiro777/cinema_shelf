
User.create!(name: "shiro777",
  email: "hideaki.shirahama@gmail.com",
  password: "password",
  password_confirmation: "password")

99.times do |n|
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
                image: image)
end