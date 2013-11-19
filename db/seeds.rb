require 'faker'

10.times do
  category = Category.create(name: Faker::Company.name)
  2.times do
    category.posts.create(title: Faker::Company.bs, description: Faker::Company.catch_phrase, price: rand(10), email: Faker::Internet.email, edit_url: Faker::Lorem.characters(9))
  end
end