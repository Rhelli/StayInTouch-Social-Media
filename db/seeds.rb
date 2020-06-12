# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'Jimbo', email: 'jimbo@email.com', password: 'password', password_confirmation: 'password')

30.times do
  name = Faker::Name.first_name
  email_domain = Faker::Internet.domain_name
  User.create!(
    name: name,
    email: name+'@'+"#{email_domain}",
    password: 'password',
    password_confirmation: 'password'
  )
end

User.all.each do |u|
  content1 = Faker::Quote.famous_last_words
  content2 = Faker::Quote.robin
  u.posts.create!(user_id: u.id, content: content1)
  u.posts.create!(user_id: u.id, content: content2)
end