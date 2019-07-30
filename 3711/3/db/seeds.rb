require 'faker'

10.times do
  User.create(username: Faker::Name.name,
              pass_hash: Faker::Crypto.md5,
              mail: Faker::Internet.email,
              first_name: Faker::Name.first_name,
              last_name: Faker::Name.last_name)
end

10.times do
  Place.create(name: Faker::Restaurant.name,
               note: Faker::Restaurant.type,
               description: Faker::Restaurant.description,
               longitude: rand(53.8359187..53.9706422),
               latitude: rand(27.4086552..27.6966526))
end

25.times do
  Review.create(place_id: Place.offset(rand(Place.count)).first.id,
                user_id: User.offset(rand(User.count)).first.id,
                rating: rand(1..5),
                text: Faker::Restaurant.review)
end
