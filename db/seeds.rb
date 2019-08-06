# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "User First",
             email: "manh@gmail.com",
             password:              "123123",
             password_confirmation: "123123",
             admin: true)

60.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

Publisher.create!(name: "Khong nha xuat ban", address: "Khong dia chi", content: "")

10.times do |n|
  name = Faker::Name.name
  address = "#{n+1} street"
  content = "content #{n+1}"
  Publisher.create!(name: name, address: address, content: content)
end

Category.create!(name: "Khong thu muc", content: "")

10.times do |n|
  name = Faker::Name.name
  content = "content #{n+1}"
  Category.create!(name: name, content: content)
end

Author.create!(name: "Khong tac gia", nickname: "Khong nickname", content: "")

10.times do |n|
  name = Faker::Name.name
  nickname = Faker::Name.name << "#{n+1}"
  content = "content #{n+1}"
  Author.create!(name: name, nickname: nickname, content: content)
end

10.times do |n|
  name = Faker::Name.name
  status = Faker::Name.name << "#{n+1}"
  content = "content #{n+1}"
  author_id = rand(1..10)
  category_id = rand(1..10)
  publisher_id = rand(1..10)
  Book.create!(name: name, status: status, content: content,
                  author_id: author_id, category_id: category_id,
                  publisher_id: publisher_id)
end